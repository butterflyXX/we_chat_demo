#!/usr/bin/env python3
import argparse
import json
import os
import sys
from urllib import request, error


def send_feishu(webhook: str, title: str, content: str, color: str = "green") -> int:
    # 将传入的 \n 文本序列转换为真实换行，兼容 shell 传参中换行丢失的情况
    if content:
        content = content.replace("\\n", "\n")
    if not webhook:
        print("[INFO] FEISHU_WEBHOOK_URL 未配置，跳过", flush=True)
        return 0

    payload = {
        "msg_type": "interactive",
        "card": {
            "config": {"wide_screen_mode": True},
            "header": {
                "title": {"tag": "plain_text", "content": title},
                "template": color or "green",
            },
            "elements": [
                {
                    "tag": "div",
                    "text": {"tag": "lark_md", "content": content},
                }
            ],
        },
    }

    data = json.dumps(payload, ensure_ascii=False).encode("utf-8")
    req = request.Request(
        webhook,
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        with request.urlopen(req, timeout=15) as resp:
            body = resp.read().decode("utf-8", errors="ignore")
            print(f"[INFO] 飞书响应: {body}")
            return 0 if resp.status in (200, 204) else 1
    except error.HTTPError as e:
        print(f"[ERROR] 飞书 HTTP 错误: {e.code} {e.reason}")
        try:
            print(e.read().decode("utf-8", errors="ignore"))
        except Exception:
            pass
        return 1
    except Exception as e:
        print(f"[ERROR] 飞书请求异常: {e}")
        return 1


def main() -> int:
    parser = argparse.ArgumentParser(description="Send Feishu notification")
    parser.add_argument("--webhook", default=os.environ.get("FEISHU_WEBHOOK_URL", ""))
    parser.add_argument("--title", required=True)
    parser.add_argument("--content", required=True)
    parser.add_argument("--color", default="green")
    args = parser.parse_args()
    return send_feishu(args.webhook, args.title, args.content, args.color)


if __name__ == "__main__":
    sys.exit(main())



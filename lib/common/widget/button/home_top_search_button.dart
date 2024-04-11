import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/color.dart';

class HomeTopSearchButton extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeTopSearchButton({
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: const Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              color: homeSearchTintColor,
              size: 20,
            ),
            Text(
              "搜索",
              style: TextStyle(color: homeSearchTintColor),
            ),
          ],
        ),
      ),
    );
  }
}

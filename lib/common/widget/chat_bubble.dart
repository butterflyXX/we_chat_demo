import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/widget/chat_bubble_back.dart';

class ChatBubble extends StatefulWidget {
  final bool inLeft;
  final String text;
  final Color textBackColor;

  const ChatBubble({
    this.inLeft = true,
    required this.text,
    this.textBackColor = Colors.green,
    super.key,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final double arrowHeight = 8;
  final double arrowY = 15;
  final double padding = 10;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: arrowY * 2 + arrowHeight * 2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: MyPainter(
                isLeft: widget.inLeft,
                borderRadius: 8,
                color: widget.textBackColor,
                arrowHeight: arrowHeight,
                arrowY: arrowY,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: widget.inLeft ? arrowHeight + padding : padding,
              top: padding,
              bottom: padding,
              right: !widget.inLeft ? arrowHeight + padding : padding,
            ),
            child: Text(widget.text,style: TextStyle(color: Colors.black,fontSize: 16),),
          ),
        ],
      ),
    );
  }
}

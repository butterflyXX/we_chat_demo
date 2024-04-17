import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTextField extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  final VoidCallback? hasFocus;
  const HomeTextField({this.onSubmit, this.hasFocus, super.key});

  @override
  State<HomeTextField> createState() => _HomeTextFieldState();
}

class _HomeTextFieldState extends State<HomeTextField> {

  TextEditingController controller = TextEditingController();

  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(_listener);
    super.initState();
  }

  _listener() {
    if (focusNode.hasFocus) {
      widget.hasFocus?.call();
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      controller: controller,
      focusNode: focusNode,
      maxLines: 10,
      minLines: 1,
      textInputAction: TextInputAction.continueAction,
      onSubmitted: (value) {
        widget.onSubmit?.call(value);
        controller.clear();
      },
    );
  }
}

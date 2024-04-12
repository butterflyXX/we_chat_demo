import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTextField extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  const HomeTextField({this.onSubmit, super.key});

  @override
  State<HomeTextField> createState() => _HomeTextFieldState();
}

class _HomeTextFieldState extends State<HomeTextField> {

  TextEditingController controller = TextEditingController();

  ValueNotifier<double> keyboardHeight = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      controller: controller,
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

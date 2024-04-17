import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/common/widget/button/icon_button.dart';

AppBar commonAppbar(
  BuildContext context, {
  Color? backgroundColor,
  Color? tintColor,
  String? title,
  Widget? textTitle,
  PreferredSizeWidget? bottom,
  double? elevation,
  VoidCallback? leadingAction,
  List<Widget>? actions,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  Widget? leading,
}) {
  final canPop = ModalRoute.of(context)?.canPop ?? false;
  final scaffold = Scaffold.maybeOf(context);
  final bool hasDrawer = scaffold?.hasDrawer ?? false;
  final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
  if ((hasDrawer || (!hasEndDrawer && canPop)) || leadingAction != null) {
    leading ??= backWidgetAction(
      backAction: leadingAction ?? () => Navigator.of(context).pop(),
      tintColor: tintColor,
    );
  }
  return AppBar(
    backgroundColor: backgroundColor ?? commonAppBarBackColor,
    elevation: elevation,
    systemOverlayStyle: systemUiOverlayStyle,
    centerTitle: true,
    title: textTitle ??
        Text(
          title ?? "",
          // style: TextStyle(
          //     fontWeight: FontWeight.w500, color: tintColor??globalCurrentTheme(context).textColor1, fontSize: 18.sp),
        ),
    leading: leading,
    actions: actions,
    bottom: bottom,
  );
}

Widget backWidgetAction({VoidCallback? backAction, Color? tintColor}) {
  return CommonIconButton(
    onTap: backAction,
    child: Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Icon(
        Icons.arrow_back_ios,
        color: tintColor,
      ),
    ),
  );
}

Widget commonActionItem({required String title, VoidCallback? onTap}) {
  return CupertinoButton(
    child: Text(
      title,
      style: TextStyle(fontSize: 15.sp),
    ),
    onPressed: onTap,
  );
}

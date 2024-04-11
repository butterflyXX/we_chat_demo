import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:we_chat_demo/common/color.dart';
import 'package:we_chat_demo/model/home_item_model.dart';

class HomeItemWidget extends StatelessWidget {
  final HomeItemModel model;

  const HomeItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(model.time);
    return SizedBox(
      height: 72.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
        child: Row(
          children: [
            Container(
              height: 48.w,
              width: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Text(
                        DateFormat("yyyy-MM-dd HH:mm").format(dateTime),
                        style: TextStyle(
                          color: disableTintColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    model.subTitle,
                    style:
                        TextStyle(fontSize: 12.sp, color: homeSearchTintColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

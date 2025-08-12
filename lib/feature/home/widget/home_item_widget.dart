import 'package:chat_demo/common/data_base/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:chat_demo/common/color.dart';

class HomeItemWidget extends StatelessWidget {
  final UserTableInfoData model;

  const HomeItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      model.createdAt,
    );
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
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.name, style: TextStyle(fontSize: 16.sp)),
                      Text(
                        DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime),
                        style: TextStyle(
                          color: disableTintColor,
                          fontSize: 12.sp,
                        ),

                      ),
                    ],
                  ),
                  Text(
                    model.lastMessage ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: homeSearchTintColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

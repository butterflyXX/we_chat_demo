import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ItemWidget({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Icon(icon, size: 24, color: Colors.black),
    ),
    SizedBox(height: 8),
    Text(title),
      ],
    );
  }
}
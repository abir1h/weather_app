import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/src/core/constants/app_theme.dart';

class TabWidget extends StatelessWidget {
  final Color bgColor;
  final VoidCallback onTap;
  final String title;
  const TabWidget({super.key, required this.bgColor, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
          color: bgColor,

        ),child: Center(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),),
      ),
    );
  }
}

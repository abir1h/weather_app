import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextWidget extends StatelessWidget {
  final String title,content;
  const TextWidget({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.sp),),
          SizedBox(width: 10.w,),
          Text(content,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.sp),),
        ],
      ),
    );
  }
}


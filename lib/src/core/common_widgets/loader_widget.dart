import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/src/core/constants/app_theme.dart';
import 'package:weather_app/src/core/constants/image_assets.dart';
class LoaderWidget extends StatelessWidget with AppTheme{
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.decal,
          colors: [clr.grad1, clr.grad2],
        ),
      ),child: Column(
      children: [
        SizedBox(height: .3.sh,),
        Lottie.asset(ImageAssets.loader),
        Text("Please wait weather is loading",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20.sp,color: Colors.white),)
      ],
    )
    );
  }
}

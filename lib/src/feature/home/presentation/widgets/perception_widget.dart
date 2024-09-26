import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/src/core/constants/image_assets.dart';
import 'package:weather_app/src/feature/home/data/models/weather_data_model.dart';
class PerceptionWidget extends StatelessWidget {
  final WeatherDataModel data;

  const PerceptionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.2),
                Colors.white.withOpacity(.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: const Alignment(0.1, 0.3),
            end: const Alignment(-0.3, 0.2),
            colors: [
              Colors.white.withOpacity(.2),
              Colors.white.withOpacity(.2),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Lottie.asset(ImageAssets.rain,height: 50.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Perception".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Text("In",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),),
                    SizedBox(width: 10.w
                      ,),

                    Text(data.current!.precipIn.toString(),style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),SizedBox(width: 20.w,),Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Perception".toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Text("MM",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),),
                    SizedBox(width: 10.w
                      ,),

                    Text(data.current!.precipMm.toString(),style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

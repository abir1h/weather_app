import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/src/core/constants/image_assets.dart';
import 'package:weather_app/src/feature/home/data/models/weather_data_model.dart';

import '../../../../core/common_widgets/text_widget.dart';
import '../service/weather_service.dart';
class FeelsLikeWidget extends ConsumerWidget {
  final WeatherDataModel data;

  const FeelsLikeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final unit = ref.watch(unitProvider);

    // Helper function to format temperature based on unit
    String formatTemperature(double temp) {
      return unit == "Celsius"
          ? "${temp.toStringAsFixed(1)} °C"
          : "${(temp * 9 / 5 + 32).toStringAsFixed(1)} °F";
    }
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
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20.sp),),
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Expanded(child: Image.asset(ImageAssets.sun_rain,height: 100.h,width: 100.w,)),
                SizedBox(width: 20.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title: "Feels Like",content: formatTemperature(data.current!.feelslikeC),),

                      TextWidget(title: "Humidity",content: "${data.current!.humidity}%",),
                      TextWidget(title: "Visibility",content: "${data.current!.visMiles} mi",),
                      TextWidget(title: "UV index",content: "${data.current!.uv} ",)

                    ],
                  ),
                )
              ],

            )
          ],
        ),
      ),
    );
  }
}

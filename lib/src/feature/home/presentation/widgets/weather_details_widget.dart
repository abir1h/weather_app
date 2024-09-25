import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:latlng/latlng.dart';
import 'package:weather_app/src/core/constants/app_theme.dart';
import 'package:weather_app/src/core/constants/image_assets.dart';
import 'package:weather_app/src/feature/home/data/mapper/current_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/weather_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/models/current_data_model.dart';
import 'package:weather_app/src/feature/home/data/models/weather_data_model.dart';
import 'package:weather_app/src/feature/home/presentation/widgets/sunset_widget.dart';
import 'package:weather_app/src/feature/home/presentation/widgets/temp_section_widget.dart';
import '../../../../core/common_widgets/tab_widget.dart';
import '../../domain/entities/current_data_entity.dart';
import 'package:weather_app/src/feature/home/domain/entities/forcast_day_data_entity.dart';
import '../../domain/entities/weather_data_entity.dart';

import '../service/weather_service.dart';
import '../widgets/location_widget.dart';

class WeatherDetails extends ConsumerWidget with AppTheme {
  final Position position;
  final WeatherDataModel weatherData;

  WeatherDetails(this.position, {super.key, required this.weatherData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(unitProvider);
    final selectedTab = ref.watch(selectedTabProvider); // Corrected line

    // Helper function to format temperature based on unit
    String formatTemperature(double temp) {
      return unit == "Celsius"
          ? "${temp.toStringAsFixed(1)} °C"
          : "${(temp * 9 / 5 + 32).toStringAsFixed(1)} °F";
    }

    // Get filtered hourly temperatures based on the selected tab
    List<CurrentDataModel> filteredList;
    if (selectedTab == 0) {
      filteredList = weatherData.forecast!.forecastday.first.hour
          .where((item) =>
              item.timeEpoch! > DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toList();
    } else {
      filteredList = weatherData.forecast!.forecastday[selectedTab].hour
          .where((item) =>
              item.timeEpoch! > DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toList();
    }

    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.decal,
            colors: [clr.grad1, clr.grad2],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 47.h),
                  LocationWidget(position: position),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(unitProvider.notifier).toggleUnit();
                      },
                      child: Text('Toggle to ${unit == "Celsius" ? "Fahrenheit" : "Celsius"}'),
                    ),
                  ),                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https:${weatherData.current!.condition.icon}",
                        height: 130.h,
                        width: 130.w,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Text(
                          formatTemperature(weatherData.current!.tempC),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: clr.whiteColor,
                              fontSize: 60.sp),
                        ),
                      ),

                    ],
                  ),
                  Center(
                    child: Text(
                      "${weatherData.current!.condition.text} - H:${formatTemperature(weatherData.forecast!.forecastday.first.day.maxtempC)} L:${formatTemperature(weatherData.forecast!.forecastday.first.day.mintempC)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.textSmall,
                          color: clr.whiteColor),
                    ),
                  ),
                  SizedBox(height: size.h20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TabWidget(
                            bgColor: selectedTab == 0
                                ? clr.grad3
                                : clr.blackColor.withOpacity(.10),
                            title: "Today",
                            onTap: () {
                              ref.read(selectedTabProvider.notifier).state = 0;
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TabWidget(
                            bgColor: selectedTab == 1
                                ? clr.grad3
                                : clr.blackColor.withOpacity(.10),
                            title: DateFormat("EEEE").format(
                                weatherData.forecast!.forecastday[1].date),
                            onTap: () {
                              ref.read(selectedTabProvider.notifier).state = 1;
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TabWidget(
                            bgColor: selectedTab == 2
                                ? clr.grad3
                                : clr.blackColor.withOpacity(.10),
                            title: DateFormat("EEEE").format(
                                weatherData.forecast!.forecastday[2].date),
                            onTap: () {
                              ref.read(selectedTabProvider.notifier).state = 2;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.h20),
                  AspectRatio(
                    aspectRatio: 16 / 8,
                    child: TempCardSectionWidget(
                      items: filteredList,
                      buildItem: (BuildContext context, int index, item) {
                        return TempCardItemWidget(
                          data: item,
                          parentData: weatherData,
                          isNow: index ==
                              0, // First item represents the current time
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.h32,),
                  SunsetWidget(data: weatherData,)
                ],
              ),
            ),
            Positioned(
              bottom: -80, // Align the image to the bottom
              left: 0,
              right: 0,
              child: Container(
                width: 1.sw,
                height: 290.h, // Adjust height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.object),
                    fit: BoxFit
                        .fitWidth, // Make sure the image fits the width of the screen
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

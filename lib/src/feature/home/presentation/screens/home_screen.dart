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
import 'package:weather_app/src/feature/home/domain/entities/current_data_entity.dart';
import 'package:weather_app/src/feature/home/domain/entities/forcast_day_data_entity.dart';
import 'package:weather_app/src/feature/home/domain/entities/weather_data_entity.dart';

import '../service/weather_service.dart';

class HomeScreen extends ConsumerWidget with AppTheme {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the location data
    final locationAsync = ref.watch(locationProvider);

    return MaterialApp(
      home: Scaffold(
        body: locationAsync.when(
          data: (position) {
            // Fetch the weather data based on the current position
            final weatherAsync = ref.watch(weatherProvider(position));
            return weatherAsync.when(
              data: (weatherData) {
                // Display the weather data
                return WeatherDetails(weatherData: weatherData, position);
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error fetching weather data: $error'),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Error fetching location: $error'),
          ),
        ),
      ),
    );
  }
}

class WeatherDetails extends ConsumerWidget with AppTheme {
  final Position position;
  final WeatherDataEntity weatherData;

  WeatherDetails(this.position, {super.key, required this.weatherData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(unitProvider);
    final currentWeather = weatherData.current;
    final forecast = weatherData.forecast?.forecastday;

    // Helper function to format temperature based on unit
    String formatTemperature(double temp) {
      if (unit == "Celsius") {
        return "${temp.toStringAsFixed(1)} °C";
      } else {
        return "${(temp * 9 / 5 + 32).toStringAsFixed(1)} °F";
      }
    }
    List<CurrentDataEntity> filteredList = weatherData.forecast!.forecastday.first.hour.where((item) {
      final currentTimeEpoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return item.timeEpoch! < currentTimeEpoch;
    }).toList();
    return Scaffold(
        body: Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.decal,
              colors: [clr.grad1, clr.grad2])),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 47.h),
            SizedBox(height: 15.h),
            LocationWidget(
              position: position,
            ),
            SizedBox(height: 15.h),
            Row(
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
                  formatTemperature(currentWeather!.tempC),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: clr.whiteColor,
                      fontSize: 60.sp),
                ))
              ],
            ),
            Center(
              child: Text(
                "${weatherData.current!.condition.text}  - H:${formatTemperature(weatherData.forecast!.forecastday.first.day.maxtempC)}L:${formatTemperature(weatherData.forecast!.forecastday.first.day.mintempC)}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.textSmall,
                    color: clr.whiteColor),
              ),
            ),
            SizedBox(
              height: size.h20,
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: TempCardSectionWidget(
                  items:
                  filteredList,
                  buildItem: (BuildContext context, int index, item) {
                    return TempCardItemWidget(
                      data: item,
                      isNow:
                          index == 0, // First item represents the current time
                      onTap: () {},
                    );
                  }),
            )
          ],
        ),
      ),
    ));

/*
    return CustomScrollView(
      slivers: [
        SliverAppBar(pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Current Weather"),
            background: Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Temperature: ${formatTemperature(currentWeather!.tempC)}",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.swap_horiz),
              onPressed: () {
                ref.read(unitProvider.notifier).toggleUnit();
              },
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weather details
                    Text("Weather: ${currentWeather.condition.text}", style: TextStyle(fontSize: 18)),
                    Text("Humidity: ${currentWeather.humidity}%", style: TextStyle(fontSize: 18)),
                    Text("Wind Speed: ${currentWeather.windKph} kph", style: TextStyle(fontSize: 18)),
                    Text("Pressure: ${currentWeather.pressureMb} hPa", style: TextStyle(fontSize: 18)),
                    Text("Visibility: ${currentWeather.visKm} km", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),

                    // 3-day Forecast
                    Text(
                      "3-Day Forecast",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    for (var day in forecast!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(day.date.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                "https:${day.day.condition.icon}",
                                width: 50,
                              ),
                              Text("Temp: ${formatTemperature(day.day.avgtempC)}", style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                  ],
                ),
              );
            },
            childCount: 1, // Only one item for the current weather details
          ),
        ),
      ],
    );
*/
  }
}

class LocationWidget extends ConsumerWidget with AppTheme {
  final Position position;

  const LocationWidget({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsyncValue = ref.watch(locationAddressProvider(position));

    return addressAsyncValue.when(
      data: (location) => Column(
        children: [
          Center(
            child: Text(
              location.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 32.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.locationIcon,
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(
                width: size.w8,
              ),
              Text(
                "Current Location",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: size.textXXSmall),
              ),
            ],
          ),
        ],
      ),
      loading: () => CircularProgressIndicator(),
      error: (e, stack) => Text('Error: $e'),
    );
  }
}

class TempCardSectionWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;

  const TempCardSectionWidget(
      {super.key, required this.items, required this.buildItem});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 12);
      },
    );
  }
}

class TempCardItemWidget extends ConsumerWidget {
  final CurrentDataEntity data;
  final bool isNow;
  final VoidCallback onTap;

  const TempCardItemWidget(
      {Key? key, required this.data, required this.isNow, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(unitProvider);

    // Helper function to format temperature based on unit
    String formatTemperature(double temp) {
      if (unit == "Celsius") {
        return "${temp.toStringAsFixed(1)} °C";
      } else {
        return "${(temp * 9 / 5 + 32).toStringAsFixed(1)} °F";
      }
    }

    // Format the time from epoch; return "Now" if this is the current weather
    String formatTimeFromEpoch(int timeEpoch) {
      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final timeDifference = currentTime - timeEpoch;

      if (timeDifference.abs() < 60) {
        return "Now";
      }

      final dateTime = DateTime.fromMillisecondsSinceEpoch(timeEpoch * 1000);
      return DateFormat('h:mm a').format(dateTime);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
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
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                begin: Alignment(0.1, 0.3),
                end: Alignment(-0.3, 0.2),
                colors: [
                  Colors.white.withOpacity(.2),
                  Colors.white.withOpacity(.2),
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  isNow ? "Now" : formatTimeFromEpoch(data.timeEpoch!),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Circular Std',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https:${data.condition.icon}"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  formatTemperature(data.tempC),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Circular Std',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 7),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
            ),
          ),
        ],
      ),
    );
  }
}

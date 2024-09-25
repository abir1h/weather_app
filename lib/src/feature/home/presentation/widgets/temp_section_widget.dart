import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/feature/home/data/models/current_data_model.dart';
import 'package:weather_app/src/feature/home/data/models/weather_data_model.dart';
import '../../domain/entities/current_data_entity.dart';
import '../../domain/entities/weather_data_entity.dart';
import '../service/weather_service.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 12);
      },
    );
  }
}

class TempCardItemWidget extends ConsumerWidget {
  final CurrentDataModel data;
  final WeatherDataModel parentData;
  final bool isNow;
  final VoidCallback onTap;

  const TempCardItemWidget(
      {super.key,
      required this.data,
      required this.isNow,
      required this.onTap,
      required this.parentData});

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
      return DateFormat('h a').format(dateTime);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
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
                begin: const Alignment(0.1, 0.3),
                end: const Alignment(-0.3, 0.2),
                colors: [
                  Colors.white.withOpacity(.2),
                  Colors.white.withOpacity(.2),
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  isNow ? "Now" : formatTimeFromEpoch(data.timeEpoch!),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Circular Std',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
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
                SizedBox(height: 8.h),
                Text(
                  isNow
                      ? formatTemperature(parentData.current!.tempC)
                      : formatTemperature(data.tempC),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Circular Std',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          isNow
              ? Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/core/constants/app_theme.dart';
import 'package:weather_app/src/core/constants/image_assets.dart';
import '../service/weather_service.dart';

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
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, stack) => Text('Error: $e'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/src/core/common_widgets/loader_widget.dart';
import 'package:weather_app/src/core/constants/app_theme.dart';
import '../service/weather_service.dart';
import '../widgets/weather_details_widget.dart';

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
              loading: () =>const LoaderWidget(),
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

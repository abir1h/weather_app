import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/src/core/routes/app_route.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../service/splash_service.dart';

class SplashScreen extends ConsumerWidget with AppTheme {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(initializationProvider, (previous, next) {
      if (next is AsyncData) {
        Navigator.of(context).pushReplacementNamed(AppRoute.homeScreen);
      }
    });

    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: .2.sh,
        ),
        Center(
            child: Lottie.asset(
          ImageAssets.splashAnitmation,
        )),
        SizedBox(
          height: size.h20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Forecast Your Day With A Reliable Way",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: size.textXLarge,
              color: Color(0xFF666870),
              height: 1,
              letterSpacing: -1,
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
              .animate() // this wraps the previous Animate in another Animate
              .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
              .slide(),
        )
      ],
    ));
  }
}

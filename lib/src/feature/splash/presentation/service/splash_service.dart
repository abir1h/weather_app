import 'package:flutter_riverpod/flutter_riverpod.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  await Future.delayed(Duration(seconds: 2));
});
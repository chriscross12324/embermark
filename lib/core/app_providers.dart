import 'package:embermark/core/app_provider_classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final temporaryPinToolbar = StateNotifierProvider<TypedProvider<bool>, bool>((ref) {
  return TypedProvider<bool>(false);
});
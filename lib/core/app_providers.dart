import 'package:embermark/core/app_constants.dart';
import 'package:embermark/core/app_provider_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final temporaryPinToolbar = StateNotifierProvider<TypedProvider<bool>, bool>((ref) {
  return TypedProvider<bool>(false);
});

final settingToolbarLocation = StateNotifierProvider<TypedProvider<Alignment>, Alignment>((ref) {
  return TypedProvider<Alignment>(Alignment.centerLeft);
});

final settingToolbarColumnCount = StateNotifierProvider<TypedProvider<int>, int>((ref) {
  return TypedProvider<int>(2);
});

final settingInterfaceScale = StateNotifierProvider<TypedProvider<InterfaceScale>, InterfaceScale>((ref) {
  return TypedProvider<InterfaceScale>(InterfaceScale.normal);
});
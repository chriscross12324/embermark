import 'dart:convert';

import 'package:flutter/cupertino.dart';

String serializePadding(EdgeInsets padding) {
  final paddingMap = {
    'left': padding.left,
    'top': padding.top,
    'right': padding.right,
    'bottom': padding.bottom,
  };
  return jsonEncode(paddingMap);
}

EdgeInsets deserializePadding(String paddingMap) {
  final paddingJson = jsonDecode(paddingMap);
  return EdgeInsets.fromLTRB(
    (paddingJson['left'] as num).toDouble(),
    (paddingJson['top'] as num).toDouble(),
    (paddingJson['right'] as num).toDouble(),
    (paddingJson['bottom'] as num).toDouble(),
  );
}

String serializeTextStyle(TextStyle textStyle) {
  final textStyleMap = {
    'color': serializeColor(textStyle.color!),
    'backgroundColour': serializeColor(textStyle.backgroundColor!),
    'fontSize': textStyle.fontSize.toString(),
    'fontWeight': textStyle.fontWeight,
    'fontStyle': textStyle.fontStyle,
    'letterSpacing': textStyle.letterSpacing.toString(),
    'wordSpacing': textStyle.wordSpacing.toString(),
    'textBaseline': textStyle.textBaseline,
    'height': textStyle.height.toString(),
    'leadingDistribution': textStyle.leadingDistribution,
    'locale': textStyle.locale,
    'foreground': textStyle.foreground,
    'background': textStyle.background,
    'shadows': textStyle.shadows,
    'fontFeatures': textStyle.fontFeatures,
    'fontVariations': textStyle.fontVariations,
    'decoration': textStyle.decoration,
    'decorationColor': serializeColor(textStyle.decorationColor!),
    'decorationStyle': textStyle.decorationStyle,
    'decorationThickness': textStyle.decorationThickness.toString(),
  };
  return jsonEncode(textStyleMap);
}

TextStyle deserializeTextStyle(String textStyleMap) {
  return TextStyle();
}

String serializeColor(Color colour) {
  final colourMap = {
    'a': colour.a,
    'r': colour.r,
    'g': colour.g,
    'b': colour.b,
  };
  return jsonEncode(colourMap);
}

Color deserializeColor(String colourMap) {
  final colourJson = jsonDecode(colourMap);
  return Color.fromARGB(
    colourJson['a'],
    colourJson['r'],
    colourJson['g'],
    colourJson['b'],
  );
}

String serializeFontWeight(FontWeight fontWeight) {
  final fontWeightMap = {
    'index': fontWeight.index,
    'value': fontWeight.value,
  };
  return jsonEncode(fontWeightMap);
}

FontWeight deserializeFontWeight(String fontWeightMap) {
  final fontWeightJson = jsonDecode(fontWeightMap);
  final fontWeight = FontWeight._()
  return FontWeight(
}
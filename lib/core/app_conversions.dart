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
    double.parse(paddingJson['left']),
    double.parse(paddingJson['top']),
    double.parse(paddingJson['right']),
    double.parse(paddingJson['bottom']),
  );
}

String serializeTextStyle(TextStyle textStyle) {
  final textStyleMap = {
    'color': serializeColor(textStyle.color!),
    'backgroundColour': serializeColor(textStyle.backgroundColor!),
    'fontSize': textStyle.fontSize.toString(),
    'fontWeight': serializeFontWeight(textStyle.fontWeight!),
    'fontStyle': serializeEnum(textStyle.fontStyle!),
    'letterSpacing': textStyle.letterSpacing.toString(),
    'wordSpacing': textStyle.wordSpacing.toString(),
    'height': textStyle.height.toString(),
    'shadows': serializeShadows(textStyle.shadows!),
  };
  return jsonEncode(textStyleMap);
}

TextStyle deserializeTextStyle(String textStyleMap) {
  final textStyleJson = jsonDecode(textStyleMap);
  return TextStyle(
    color: deserializeColor(textStyleJson['color']),
    backgroundColor: deserializeColor(textStyleJson['backgroundColour']),
    fontSize: double.parse(textStyleJson['fontSize']),
    fontWeight: deserializeFontWeight(textStyleJson['fontWeight']),
    fontStyle: deserializeEnum(
      textStyleJson['fontStyle'],
      FontStyle.values,
      fallback: FontStyle.normal,
    ),
    letterSpacing: double.parse(textStyleJson['letterSpacing']),
    wordSpacing: double.parse(textStyleJson['wordSpacing']),
    height: double.parse(textStyleJson['height']),
    shadows: deserializeShadows(textStyleJson['shadows']),
  );
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
  return Color.from(
    alpha: colourJson['a'],
    red: colourJson['r'],
    green: colourJson['g'],
    blue: colourJson['b'],
  );
}

String serializeFontWeight(FontWeight fontWeight) {
  return jsonEncode({'value': fontWeight.value});
}

FontWeight deserializeFontWeight(String fontWeightMap) {
  final fontWeightJson = jsonDecode(fontWeightMap);
  return FontWeight.values.firstWhere(
    (fw) => fw.value == fontWeightJson['value'],
    orElse: () => FontWeight.normal,
  );
}

String serializeShadows(List<Shadow> shadowList) {
  final List<String> shadowListMap = [];
  for (final shadow in shadowList) {
    final shadowMap = serializeShadow(shadow);
    shadowListMap.add(jsonEncode(shadowMap));
  }
  return jsonEncode(shadowListMap);
}

List<Shadow> deserializeShadows(String shadowListMap) {
  final shadowListJson = jsonDecode(shadowListMap);
  final shadowList = List<Map<String, dynamic>>.from(
    shadowListJson.map((item) => Map<String, dynamic>.from(item)),
  );

  return [Shadow()];
  /*List<Shadow> shadows = [];
  for (final shadow in shadowList) {
    final shadowObject = deserializeShadow(shadow);
  }*/
}

String serializeShadow(Shadow shadow) {
  final shadowMap = {
    'color': serializeColor(shadow.color),
    'offset': serializeOffset(shadow.offset),
    'blurRadius': shadow.blurRadius.toString(),
  };
  return jsonEncode(shadowMap);
}

Shadow deserializeShadow(String shadowMap) {
  final shadowJson = jsonDecode(shadowMap);
  return Shadow(
    color: deserializeColor(shadowJson['color']),
    offset: deserializeOffset(shadowJson['offset']),
    blurRadius: double.parse(shadowJson['blurRadius']),
  );
}

String serializeOffset(Offset offset) {
  final offsetMap = {'dx': offset.dx.toString(), 'dy': offset.dy.toString()};
  return jsonEncode(offsetMap);
}

Offset deserializeOffset(String offsetMap) {
  final offsetJson = jsonDecode(offsetMap);
  return Offset(double.parse(offsetJson['dx']), double.parse(offsetJson['dy']));
}

String serializeEnum(Enum e) {
  return jsonEncode({'name': e.name});
}

T deserializeEnum<T extends Enum>(
  String enumMap,
  List<T> values, {
  required T fallback,
}) {
  final enumJson = jsonDecode(enumMap);
  if (enumJson['name'] == null) return fallback;

  return values.firstWhere(
    (e) => e.name == enumJson['name'],
    orElse: () => fallback,
  );
}

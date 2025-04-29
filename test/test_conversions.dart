import 'dart:convert';
import 'dart:math';

import 'package:embermark/core/app_conversions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Colour Serialization', () {
    test('Test Colour Serialization', () {
      final colour = Color.from(alpha: 0.2847, red: 0.9123, green: 0.5078, blue: 0.0652);

      //Serialize Colour (JSON)
      final actual = serializeColor(colour);

      expect(actual, '{"a":0.2847,"r":0.9123,"g":0.5078,"b":0.0652}');
    });

    test('Test Colour Deserialization', () {
      final colourMap = '{"a":0.7324,"r":0.8414,"g":0.6783,"b":0.1003}';

      //Deserialize Colour (Color)
      final actual = deserializeColor(colourMap);

      expect(actual.a, 0.7324);
      expect(actual.r, 0.8414);
      expect(actual.g, 0.6783);
      expect(actual.b, 0.1003);
    });

    test('Test Colour Full', () {
      final colour = Color.from(alpha: 0.4216, red: 0.2415, green: 0.0104, blue: 0.0381);

      //Serialize Colour (JSON)
      final intermediary = serializeColor(colour);

      //Deserialize Colour (Color)
      final actual = deserializeColor(intermediary);

      expect(actual.a, 0.4216);
      expect(actual.r, 0.2415);
      expect(actual.g, 0.0104);
      expect(actual.b, 0.0381);
    });
  });
  group('Shadow Serialization', () {
    test('Test Shadow Serialization', () {
      final testShadow = Shadow(
        color: Colors.white,
        offset: Offset(0.5, 1.5),
        blurRadius: 12.5,
      );
      final expected = '{"color":"{\\"a\\":1.0,\\"r\\":1.0,\\"g\\":1.0,\\"b\\":1.0}","offset":"{\\"dx\\":\\"0.5\\",\\"dy\\":\\"1.5\\"}","blurRadius":"12.5"}';

      //Serialize Shadow (JSON)
      final result = serializeShadow(testShadow);

      expect(result, expected);
    });

    test('Test Shadow Deserialization', () {
      final testOriginal = '{"color":"{\\"a\\":1.0,\\"r\\":1.0,\\"g\\":1.0,\\"b\\":1.0}","offset":"{\\"dx\\":\\"0.5\\",\\"dy\\":\\"1.5\\"}","blurRadius":"12.5"}';

      //Deserialize Shadow (Shadow)
      final result = deserializeShadow(testOriginal);

      expect(result.color, Color.from(alpha: 1, red: 1, green: 1, blue: 1));
      expect(result.offset, Offset(0.5, 1.5));
      expect(result.blurRadius, 12.5);
    });

    test('Test Shadow Full', () {
      final testShadow = Shadow(
        color: Colors.white,
        offset: Offset(0.5, 1.5),
        blurRadius: 12.5,
      );

      //Serialize Shadow (JSON)
      final result1 = serializeShadow(testShadow);

      //Deserialize Shadow (Shadow)
      final result2 = deserializeShadow(result1);

      expect(testShadow.color, result2.color);
      expect(testShadow.offset, result2.offset);
      expect(testShadow.blurRadius, result2.blurRadius);
    });
  });
}

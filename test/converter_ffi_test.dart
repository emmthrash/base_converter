import 'package:flutter_test/flutter_test.dart';

import 'package:base_converter/ffi/converter_ffi.dart';

void main() {
  test('C converter converts hexadecimal to binary', () {
    final converter = ConverterFFI();

    final result = converter.convert(
      '2F',
      16,
      2,
    );

    expect(result, '101111');
  });

  test('C converter rejects invalid binary', () {
    final converter = ConverterFFI();

    final result = converter.convert(
      '129',
      2,
      10,
    );

    expect(result, isNull);
  });
}

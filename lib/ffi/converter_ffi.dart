import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

enum ConversionStatus {
  success,
  invalidInput,
  invalidBase,
  overflow,
}

class ConversionResult {
  final ConversionStatus status;
  final String? value;

  const ConversionResult({
    required this.status,
    this.value,
  });

  bool get isSuccess => status == ConversionStatus.success;
}

typedef ConvertNumberNative = Int32 Function(
  Pointer<Utf8> input,
  Int32 sourceBase,
  Int32 targetBase,
  Pointer<Utf8> output,
);

typedef ConvertNumberDart = int Function(
  Pointer<Utf8> input,
  int sourceBase,
  int targetBase,
  Pointer<Utf8> output,
);

class ConverterFFI {
  late final DynamicLibrary _library;
  late final ConvertNumberDart _convertNumber;

  ConverterFFI() {
    if (Platform.isAndroid) {
      _library = DynamicLibrary.open('libconverter.so');
    } else {
      throw UnsupportedError(
        'C converter is currently supported on Android.',
      );
    }

    _convertNumber = _library.lookupFunction<
        ConvertNumberNative,
        ConvertNumberDart>(
      'convert_number',
    );
  }

  ConversionResult convert(
    String input,
    int sourceBase,
    int targetBase,
  ) {
    final inputPointer = input.toNativeUtf8();

    final outputPointer = calloc<Uint8>(65);
    final outputUtf8 = outputPointer.cast<Utf8>();

    final result = _convertNumber(
      inputPointer,
      sourceBase,
      targetBase,
      outputUtf8,
    );

    ConversionResult conversionResult;

    switch (result) {
      case 1:
        conversionResult = ConversionResult(
          status: ConversionStatus.success,
          value: outputUtf8.toDartString(),
        );
        break;

      case 0:
        conversionResult = const ConversionResult(
          status: ConversionStatus.invalidInput,
        );
        break;

      case -1:
        conversionResult = const ConversionResult(
          status: ConversionStatus.invalidBase,
        );
        break;

      case -2:
        conversionResult = const ConversionResult(
          status: ConversionStatus.overflow,
        );
        break;

      default:
        conversionResult = const ConversionResult(
          status: ConversionStatus.invalidInput,
        );
    }

    calloc.free(inputPointer);
    calloc.free(outputPointer);

    return conversionResult;
  }
}

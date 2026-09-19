import 'package:flutter_test/flutter_test.dart';

import 'package:base_converter/main.dart';

void main() {
  testWidgets('Base Converter app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const BaseConverterApp());

    expect(find.text('Base Converter'), findsWidgets);
  });
}

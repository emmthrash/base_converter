import 'package:flutter/material.dart';

import '../ffi/converter_ffi.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController inputController = TextEditingController();

  final ConverterFFI converterFFI = ConverterFFI();

  int sourceBase = 10;
  int targetBase = 2;

  String result = '';
  String? errorMessage;

  final List<int> bases = [2, 8, 10, 16];

  String getBaseName(int base) {
    switch (base) {
      case 2:
        return 'Binary';
      case 8:
        return 'Octal';
      case 10:
        return 'Decimal';
      case 16:
        return 'Hexadecimal';
      default:
        return 'Unknown';
    }
  }

  void convert() {
    final input = inputController.text.trim();

    setState(() {
      result = '';
      errorMessage = null;
    });

    if (input.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a number.';
      });
      return;
    }

    final conversionResult = converterFFI.convert(
      input,
      sourceBase,
      targetBase,
    );

    setState(() {
      switch (conversionResult.status) {
        case ConversionStatus.success:
          result = conversionResult.value ?? '';
          break;

        case ConversionStatus.invalidInput:
          errorMessage =
              'Invalid input for the selected base!';
          break;

        case ConversionStatus.invalidBase:
          errorMessage =
              'Invalid source or target base!';
          break;

        case ConversionStatus.overflow:
          errorMessage =
              'Number exceeds the supported limit.';
          break;
      }
    });
  }

  void swapBases() {
    setState(() {
      final oldSource = sourceBase;
      sourceBase = targetBase;
      targetBase = oldSource;

      result = '';
      errorMessage = null;
    });
  }

  void clearAll() {
    setState(() {
      inputController.clear();
      result = '';
      errorMessage = null;
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          Text(
            'Number Base Converter',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Convert between Binary, Octal, Decimal and Hexadecimal.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 28),

          TextField(
            controller: inputController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => convert(),
            decoration: InputDecoration(
              labelText: 'Enter number',
              hintText: sourceBase == 16
                  ? 'Example: 2F or FF'
                  : 'Enter a number',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.numbers_rounded),
            ),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<int>(
            initialValue: sourceBase,
            decoration: const InputDecoration(
              labelText: 'From',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.input_rounded),
            ),
            items: bases.map((base) {
              return DropdownMenuItem<int>(
                value: base,
                child: Text(
                  '$base = ${getBaseName(base)}',
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                sourceBase = value;
                result = '';
                errorMessage = null;
              });
            },
          ),

          const SizedBox(height: 16),

          Center(
            child: IconButton.filledTonal(
              onPressed: swapBases,
              tooltip: 'Swap bases',
              icon: const Icon(Icons.swap_vert_rounded),
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            initialValue: targetBase,
            decoration: const InputDecoration(
              labelText: 'To',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.output_rounded),
            ),
            items: bases.map((base) {
              return DropdownMenuItem<int>(
                value: base,
                child: Text(
                  '$base = ${getBaseName(base)}',
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                targetBase = value;
                result = '';
                errorMessage = null;
              });
            },
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: convert,
            icon: const Icon(Icons.calculate_rounded),
            label: const Text('CONVERT'),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: clearAll,
            icon: const Icon(Icons.clear_rounded),
            label: const Text('CLEAR'),
          ),

          const SizedBox(height: 28),

          if (result.isNotEmpty) ...[
            Text(
              'Result',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SelectableText(
                  result,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],

          if (errorMessage != null) ...[
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error_outline_rounded),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 24),

          Text(
            'Supported bases: 2, 8, 10 and 16',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),

          const SizedBox(height: 4),

          Text(
            'Maximum value: 18,446,744,073,709,551,615',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

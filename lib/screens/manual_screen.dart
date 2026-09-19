import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Manual',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.menu_book_rounded,
            size: 55,
          ),

          const SizedBox(height: 16),

          Text(
            'How to use Base Converter',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 20),

          const Text(
            '1. Enter the number you want to convert.\n\n'
            '2. Select the base of the number under "From".\n\n'
            '3. Select the base you want to convert to under "To".\n\n'
            '4. Press CONVERT to perform the conversion.\n\n'
            '5. Use the swap button to exchange the source and target bases.',
          ),

          const SizedBox(height: 28),

          Text(
            'Supported Bases',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Binary — Base 2 — digits 0 and 1\n'
            'Octal — Base 8 — digits 0 to 7\n'
            'Decimal — Base 10 — digits 0 to 9\n'
            'Hexadecimal — Base 16 — digits 0 to 9 and A to F',
          ),

          const SizedBox(height: 28),

          Text(
            'Conversion Method',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 12),

          const Text(
            'The converter uses a universal two-step method:\n\n'
            'Source Base → Decimal → Target Base\n\n'
            'First, the input is converted to decimal using positional '
            'notation. The decimal value is then converted to the '
            'selected target base using repeated division and remainders.',
          ),
        ],
      ),
    );
  }
}

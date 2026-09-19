import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.swap_horiz_rounded,
            size: 70,
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              'Base Converter',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Base Converter is a lightweight offline application '
            'for converting numbers between Binary, Octal, Decimal, '
            'and Hexadecimal number systems.',
          ),

          const SizedBox(height: 20),

          const Text(
            'Built with Flutter and Dart, with a native C conversion '
            'engine planned for the computational layer.',
          ),

          const SizedBox(height: 30),

          const Center(
            child: Text(
              'Offline • Lightweight • Cross-platform',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


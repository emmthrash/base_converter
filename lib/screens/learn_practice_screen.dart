import 'package:flutter/material.dart';

class LearnPracticeScreen extends StatefulWidget {
  const LearnPracticeScreen({super.key});

  @override
  State<LearnPracticeScreen> createState() => _LearnPracticeScreenState();
}

class _LearnPracticeScreenState extends State<LearnPracticeScreen> {
  String selectedTopic = 'Basics';

  final List<String> topics = [
    'Basics',
    'Decimal → Binary',
    'Binary → Decimal',
    'Decimal → Hex',
    'Hex → Decimal',
    'Universal Method',
    'Practice',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            initialValue: selectedTopic,
            decoration: const InputDecoration(
              labelText: 'Choose a lesson',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school_rounded),
            ),
            items: topics.map((topic) {
              return DropdownMenuItem(
                value: topic,
                child: Text(topic),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                selectedTopic = value;
              });
            },
          ),

          const SizedBox(height: 20),

          _buildLesson(),
        ],
      ),
    );
  }

  Widget _buildLesson() {
    switch (selectedTopic) {
      case 'Decimal → Binary':
        return const DecimalToBinaryLesson();

      case 'Binary → Decimal':
        return const BinaryToDecimalLesson();

      case 'Decimal → Hex':
        return const DecimalToHexLesson();

      case 'Hex → Decimal':
        return const HexToDecimalLesson();

      case 'Universal Method':
        return const UniversalMethodLesson();

      case 'Practice':
        return const PracticeLesson();

      default:
        return const BasicsLesson();
    }
  }
}

/* -------------------------------------------------------------------------- */
/*                              SHARED WIDGETS                                */
/* -------------------------------------------------------------------------- */

class LessonTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const LessonTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData icon;

  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.icon = Icons.lightbulb_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class FlowBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const FlowBox({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: 90),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class ArrowDown extends StatelessWidget {
  const ArrowDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_downward_rounded,
      color: Theme.of(context).colorScheme.primary,
      size: 30,
    );
  }
}

class StepRow extends StatelessWidget {
  final int step;
  final String operation;
  final String result;
  final String remainder;

  const StepRow({
    super.key,
    required this.step,
    required this.operation,
    required this.result,
    required this.remainder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            child: Text('$step'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              operation,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '= $result',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Text(
              'R $remainder',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PositionalDigit extends StatelessWidget {
  final String digit;
  final String power;
  final String value;

  const PositionalDigit({
    super.key,
    required this.digit,
    required this.power,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            digit,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            power,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                  BASICS                                    */
/* -------------------------------------------------------------------------- */

class BasicsLesson extends StatelessWidget {
  const BasicsLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Number Bases',
          subtitle:
              'A number base tells us how many different digits are available.',
        ),

        SectionCard(
          title: 'The four bases in this app',
          icon: Icons.numbers_rounded,
          child: Column(
            children: const [
              BaseInfo(
                base: '2',
                name: 'Binary',
                digits: '0, 1',
              ),
              BaseInfo(
                base: '8',
                name: 'Octal',
                digits: '0 – 7',
              ),
              BaseInfo(
                base: '10',
                name: 'Decimal',
                digits: '0 – 9',
              ),
              BaseInfo(
                base: '16',
                name: 'Hexadecimal',
                digits: '0 – 9, A – F',
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'How the converter thinks',
          icon: Icons.account_tree_rounded,
          child: Column(
            children: [
              Row(
                children: const [
                  FlowBox(
                    title: 'SOURCE',
                    subtitle: 'Your number',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward_rounded),
                  ),
                  FlowBox(
                    title: 'DECIMAL',
                    subtitle: 'Common working form',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward_rounded),
                  ),
                  FlowBox(
                    title: 'TARGET',
                    subtitle: 'Requested base',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Example: 2F₁₆ → 47₁₀ → 101111₂',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'Key idea',
          icon: Icons.key_rounded,
          child: const Text(
            'The converter does not need a separate algorithm for every pair '
            'of bases. It converts the source number into decimal first, '
            'then converts decimal into the requested target base.',
          ),
        ),
      ],
    );
  }
}

class BaseInfo extends StatelessWidget {
  final String base;
  final String name;
  final String digits;

  const BaseInfo({
    super.key,
    required this.base,
    required this.name,
    required this.digits,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(base),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('Digits: $digits'),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          DECIMAL → BINARY                                  */
/* -------------------------------------------------------------------------- */

class DecimalToBinaryLesson extends StatelessWidget {
  const DecimalToBinaryLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Decimal → Binary',
          subtitle:
              'Keep dividing by 2 and record the remainder each time.',
        ),

        SectionCard(
          title: 'Worked example: 45₁₀ → ?₂',
          icon: Icons.calculate_rounded,
          child: Column(
            children: [
              const StepRow(
                step: 1,
                operation: '45 ÷ 2',
                result: '22',
                remainder: '1',
              ),
              const StepRow(
                step: 2,
                operation: '22 ÷ 2',
                result: '11',
                remainder: '0',
              ),
              const StepRow(
                step: 3,
                operation: '11 ÷ 2',
                result: '5',
                remainder: '1',
              ),
              const StepRow(
                step: 4,
                operation: '5 ÷ 2',
                result: '2',
                remainder: '1',
              ),
              const StepRow(
                step: 5,
                operation: '2 ÷ 2',
                result: '1',
                remainder: '0',
              ),
              const StepRow(
                step: 6,
                operation: '1 ÷ 2',
                result: '0',
                remainder: '1',
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Read the remainders from BOTTOM → TOP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '101101₂',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'The algorithm',
          icon: Icons.code_rounded,
          child: const Text(
            '1. Divide the decimal number by the target base.\n'
            '2. Save the remainder.\n'
            '3. Divide the quotient again.\n'
            '4. Continue until the quotient becomes 0.\n'
            '5. Reverse the remainders.',
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          BINARY → DECIMAL                                  */
/* -------------------------------------------------------------------------- */

class BinaryToDecimalLesson extends StatelessWidget {
  const BinaryToDecimalLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Binary → Decimal',
          subtitle:
              'Use powers of 2 to find the decimal value of every digit.',
        ),

        SectionCard(
          title: 'Worked example: 101101₂ → ?₁₀',
          icon: Icons.grid_view_rounded,
          child: Column(
            children: [
              Row(
                children: const [
                  PositionalDigit(
                    digit: '1',
                    power: '2⁵ = 32',
                    value: '1 × 32 = 32',
                  ),
                  PositionalDigit(
                    digit: '0',
                    power: '2⁴ = 16',
                    value: '0 × 16 = 0',
                  ),
                  PositionalDigit(
                    digit: '1',
                    power: '2³ = 8',
                    value: '1 × 8 = 8',
                  ),
                  PositionalDigit(
                    digit: '1',
                    power: '2² = 4',
                    value: '1 × 4 = 4',
                  ),
                  PositionalDigit(
                    digit: '0',
                    power: '2¹ = 2',
                    value: '0 × 2 = 0',
                  ),
                  PositionalDigit(
                    digit: '1',
                    power: '2⁰ = 1',
                    value: '1 × 1 = 1',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                '32 + 0 + 8 + 4 + 0 + 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Icon(Icons.arrow_downward_rounded),

              const SizedBox(height: 8),

              Text(
                '45₁₀',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'Visual rule',
          icon: Icons.rule_rounded,
          child: const Text(
            'Starting from the right, the place values are:\n\n'
            '1 → 2 → 4 → 8 → 16 → 32 → 64 → ...\n\n'
            'Each position is twice the value of the position before it.',
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                           DECIMAL → HEX                                    */
/* -------------------------------------------------------------------------- */

class DecimalToHexLesson extends StatelessWidget {
  const DecimalToHexLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Decimal → Hexadecimal',
          subtitle:
              'Divide by 16 and convert remainders 10–15 into A–F.',
        ),

        SectionCard(
          title: 'Worked example: 47₁₀ → ?₁₆',
          icon: Icons.hexagon_outlined,
          child: Column(
            children: [
              const StepRow(
                step: 1,
                operation: '47 ÷ 16',
                result: '2',
                remainder: '15 = F',
              ),
              const StepRow(
                step: 2,
                operation: '2 ÷ 16',
                result: '0',
                remainder: '2',
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Read remainders from BOTTOM → TOP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '2F₁₆',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'Hexadecimal digit map',
          icon: Icons.table_chart_rounded,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              HexChip(label: '10 = A'),
              HexChip(label: '11 = B'),
              HexChip(label: '12 = C'),
              HexChip(label: '13 = D'),
              HexChip(label: '14 = E'),
              HexChip(label: '15 = F'),
            ],
          ),
        ),
      ],
    );
  }
}

class HexChip extends StatelessWidget {
  final String label;

  const HexChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.circle, size: 10),
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                           HEX → DECIMAL                                    */
/* -------------------------------------------------------------------------- */

class HexToDecimalLesson extends StatelessWidget {
  const HexToDecimalLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Hexadecimal → Decimal',
          subtitle:
              'Use powers of 16 and remember that A–F represent 10–15.',
        ),

        SectionCard(
          title: 'Worked example: 2F₁₆ → ?₁₀',
          icon: Icons.grid_view_rounded,
          child: Column(
            children: [
              Row(
                children: const [
                  PositionalDigit(
                    digit: '2',
                    power: '16¹ = 16',
                    value: '2 × 16 = 32',
                  ),
                  PositionalDigit(
                    digit: 'F',
                    power: '16⁰ = 1',
                    value: '15 × 1 = 15',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                '32 + 15',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Icon(Icons.arrow_downward_rounded),

              const SizedBox(height: 8),

              Text(
                '47₁₀',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'Remember',
          icon: Icons.memory_rounded,
          child: const Text(
            'A = 10\n'
            'B = 11\n'
            'C = 12\n'
            'D = 13\n'
            'E = 14\n'
            'F = 15',
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         UNIVERSAL METHOD                                   */
/* -------------------------------------------------------------------------- */

class UniversalMethodLesson extends StatelessWidget {
  const UniversalMethodLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Universal Conversion Method',
          subtitle:
              'This is the same basic strategy used by the C conversion engine.',
        ),

        SectionCard(
          title: 'The complete path',
          icon: Icons.route_rounded,
          child: Column(
            children: [
              Row(
                children: const [
                  FlowBox(
                    title: 'SOURCE',
                    subtitle: '2F₁₆',
                  ),
                ],
              ),

              const ArrowDown(),

              const Text(
                '1. Convert source → decimal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const ArrowDown(),

              Row(
                children: const [
                  FlowBox(
                    title: 'DECIMAL',
                    subtitle: '47₁₀',
                  ),
                ],
              ),

              const ArrowDown(),

              const Text(
                '2. Convert decimal → target',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const ArrowDown(),

              Row(
                children: const [
                  FlowBox(
                    title: 'TARGET',
                    subtitle: '101111₂',
                  ),
                ],
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'Inside the C engine',
          icon: Icons.memory_rounded,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AlgorithmStep(
                number: '1',
                text: 'Read each character from the input.',
              ),
              AlgorithmStep(
                number: '2',
                text: 'Convert the character into a numeric digit.',
              ),
              AlgorithmStep(
                number: '3',
                text: 'Check whether the digit is valid for the source base.',
              ),
              AlgorithmStep(
                number: '4',
                text: 'Build decimal using: result = result × base + digit.',
              ),
              AlgorithmStep(
                number: '5',
                text: 'Repeatedly divide decimal by the target base.',
              ),
              AlgorithmStep(
                number: '6',
                text: 'Store each remainder.',
              ),
              AlgorithmStep(
                number: '7',
                text: 'Reverse the remainder sequence.',
              ),
              AlgorithmStep(
                number: '8',
                text: 'Return the final converted number.',
              ),
            ],
          ),
        ),

        SectionCard(
          title: 'Why this is powerful',
          icon: Icons.bolt_rounded,
          child: const Text(
            'Instead of writing separate code for binary → hexadecimal, '
            'octal → binary, hexadecimal → octal, and every other pair, '
            'the engine only needs two core algorithms:\n\n'
            'SOURCE → DECIMAL\n'
            'DECIMAL → TARGET\n\n'
            'That gives one reusable conversion system for all supported bases.',
          ),
        ),
      ],
    );
  }
}

class AlgorithmStep extends StatelessWidget {
  final String number;
  final String text;

  const AlgorithmStep({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            child: Text(
              number,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                PRACTICE                                    */
/* -------------------------------------------------------------------------- */

class PracticeLesson extends StatefulWidget {
  const PracticeLesson({super.key});

  @override
  State<PracticeLesson> createState() => _PracticeLessonState();
}

class _PracticeLessonState extends State<PracticeLesson> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LessonTitle(
          title: 'Practice',
          subtitle:
              'Try the problem yourself before revealing the worked answer.',
        ),

        SectionCard(
          title: 'Question 1',
          icon: Icons.quiz_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Convert 37₁₀ to binary.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                icon: Icon(
                  showAnswer
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
                label: Text(
                  showAnswer ? 'Hide Answer' : 'Show Answer',
                ),
              ),

              if (showAnswer) ...[
                const SizedBox(height: 16),

                const StepRow(
                  step: 1,
                  operation: '37 ÷ 2',
                  result: '18',
                  remainder: '1',
                ),
                const StepRow(
                  step: 2,
                  operation: '18 ÷ 2',
                  result: '9',
                  remainder: '0',
                ),
                const StepRow(
                  step: 3,
                  operation: '9 ÷ 2',
                  result: '4',
                  remainder: '1',
                ),
                const StepRow(
                  step: 4,
                  operation: '4 ÷ 2',
                  result: '2',
                  remainder: '0',
                ),
                const StepRow(
                  step: 5,
                  operation: '2 ÷ 2',
                  result: '1',
                  remainder: '0',
                ),
                const StepRow(
                  step: 6,
                  operation: '1 ÷ 2',
                  result: '0',
                  remainder: '1',
                ),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    '100101₂',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),

        SectionCard(
          title: 'More questions',
          icon: Icons.edit_note_rounded,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PracticeQuestion(
                number: '2',
                question: '25₁₀ → binary',
              ),
              PracticeQuestion(
                number: '3',
                question: '10101₂ → decimal',
              ),
              PracticeQuestion(
                number: '4',
                question: '63₁₀ → hexadecimal',
              ),
              PracticeQuestion(
                number: '5',
                question: '3A₁₆ → decimal',
              ),
              PracticeQuestion(
                number: '6',
                question: '11111111₂ → hexadecimal',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PracticeQuestion extends StatelessWidget {
  final String number;
  final String question;

  const PracticeQuestion({
    super.key,
    required this.number,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            child: Text(number),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

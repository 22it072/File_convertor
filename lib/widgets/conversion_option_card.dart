import 'package:flutter/material.dart';
import 'package:file_converter/models/conversion_type.dart';

class ConversionOptionCard extends StatelessWidget {
  final ConversionType option;
  final VoidCallback onTap;

  const ConversionOptionCard({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(option.icon, height: 48),
              const SizedBox(height: 16),
              Text(
                option.title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
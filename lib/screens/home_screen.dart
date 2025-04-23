import 'package:flutter/material.dart';
import 'package:file_converter/models/conversion_type.dart';
import 'package:file_converter/widgets/conversion_option_card.dart';
import 'package:file_converter/screens/conversion_screen.dart';
import 'package:file_converter/utils/constants.dart';

import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Converter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: conversionOptions.length,
          itemBuilder: (context, index) {
            final option = conversionOptions[index];
            return ConversionOptionCard(
              option: option,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversionScreen(conversionType: option),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
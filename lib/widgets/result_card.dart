import 'package:flutter/material.dart';
import 'package:file_converter/utils/helpers.dart';
import 'package:share_plus/share_plus.dart';

class ResultCard extends StatelessWidget {
  final String filePath;
  final String fileType;

  const ResultCard({
    super.key,
    required this.filePath,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.check_circle, size: 48, color: Colors.green),
            const SizedBox(height: 16),
            Text(
              'Conversion successful!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'File saved as: ${getFileName(filePath)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    Share.shareFiles([filePath]);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.save_alt),
                  onPressed: () {
                    // Save to gallery/downloads
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () {
                    // Open file
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
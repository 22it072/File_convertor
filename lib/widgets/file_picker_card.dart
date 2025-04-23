import 'package:flutter/material.dart';
import 'package:file_converter/services/file_picker_service.dart';

class FilePickerCard extends StatelessWidget {
  final String fileType;
  final Function(String) onFileSelected;

  const FilePickerCard({
    super.key,
    required this.fileType,
    required this.onFileSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file, size: 48),
            const SizedBox(height: 16),
            Text(
              'Select $fileType file',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final path = await FilePickerService.pickFile([fileType]);
                if (path != null) {
                  onFileSelected(path);
                }
              },
              child: const Text('Choose File'),
            ),
          ],
        ),
      ),
    );
  }
}
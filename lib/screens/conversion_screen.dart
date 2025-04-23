import 'package:flutter/material.dart';
import 'package:file_converter/models/conversion_type.dart';
import 'package:file_converter/widgets/file_picker_card.dart';
import 'package:file_converter/widgets/result_card.dart';
import 'package:file_converter/services/file_converter_service.dart';

class ConversionScreen extends StatefulWidget {
  final ConversionType conversionType;

  const ConversionScreen({super.key, required this.conversionType});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String? inputFilePath;
  String? outputFilePath;
  bool isConverting = false;
  double progress = 0;

  Future<void> convertFile() async {
    if (inputFilePath == null) return;

    setState(() {
      isConverting = true;
      progress = 0;
    });

    try {
      outputFilePath = await FileConverterService.convert(
        inputPath: inputFilePath!,
        from: widget.conversionType.from,
        to: widget.conversionType.to,
        onProgress: (double p) {
          setState(() {
            progress = p;
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conversion failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isConverting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.conversionType.from} to ${widget.conversionType.to}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FilePickerCard(
              fileType: widget.conversionType.from,
              onFileSelected: (path) {
                setState(() {
                  inputFilePath = path;
                  outputFilePath = null;
                });
              },
            ),
            const SizedBox(height: 20),
            if (isConverting)
              LinearProgressIndicator(value: progress),
            if (inputFilePath != null && !isConverting)
              ElevatedButton(
                onPressed: convertFile,
                child: const Text('Convert'),
              ),
            if (outputFilePath != null)
              ResultCard(
                filePath: outputFilePath!,
                fileType: widget.conversionType.to,
              ),
          ],
        ),
      ),
    );
  }
}
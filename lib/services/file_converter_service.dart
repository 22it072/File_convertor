import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:path/path.dart' as p;

class FileConverterService {
  static Future<String> convert({
    required String inputPath,
    required String from,
    required String to,
    required Function(double) onProgress,
  }) async {
    final outputDir = (await getTemporaryDirectory()).path;
    final fileName = p.basenameWithoutExtension(inputPath);
    final outputPath = '$outputDir/$fileName.$to';

    onProgress(0.1);

    try {
      if (from == 'pdf' && to == 'jpg') {
        await _convertPdfToJpg(inputPath, outputPath, onProgress);
      } else if (from == 'jpg' && to == 'png') {
        await _convertImage(inputPath, outputPath, to, onProgress);
      } else if (from == 'png' && to == 'jpg') {
        await _convertImage(inputPath, outputPath, to, onProgress);
      } else {
        throw Exception('Unsupported conversion: $from to $to');
      }

      onProgress(1.0);
      return outputPath;
    } catch (e) {
      File(outputPath).deleteSync();
      rethrow;
    }
  }

  static Future<void> _convertPdfToJpg(
      String inputPath,
      String outputPath,
      Function(double) onProgress,
      ) async {
    // This is a simplified version - consider using a proper PDF rendering library
    final pdf = pw.Document();
    final image = img.decodeImage(File(inputPath).readAsBytesSync())!;
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(pw.MemoryImage(
            Uint8List.fromList(img.encodeJpg(image)),
          )),
        );
      },
    ));

    final file = File(outputPath);
    await file.writeAsBytes(await pdf.save());
    onProgress(0.8);
  }

  static Future<void> _convertImage(
      String inputPath,
      String outputPath,
      String format,
      Function(double) onProgress,
      ) async {
    final image = img.decodeImage(File(inputPath).readAsBytesSync())!;
    final bytes = format == 'jpg'
        ? img.encodeJpg(image)
        : img.encodePng(image);

    await File(outputPath).writeAsBytes(bytes);
    onProgress(0.8);
  }
}
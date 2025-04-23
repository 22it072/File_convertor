import 'dart:convert';

class ConversionHistory {
  final String inputPath;
  final String outputPath;
  final String fromFormat;
  final String toFormat;
  final DateTime date;

  ConversionHistory({
    required this.inputPath,
    required this.outputPath,
    required this.fromFormat,
    required this.toFormat,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'inputPath': inputPath,
      'outputPath': outputPath,
      'fromFormat': fromFormat,
      'toFormat': toFormat,
      'date': date.toIso8601String(),
    };
  }

  factory ConversionHistory.fromJson(Map<String, dynamic> json) {
    return ConversionHistory(
      inputPath: json['inputPath'],
      outputPath: json['outputPath'],
      fromFormat: json['fromFormat'],
      toFormat: json['toFormat'],
      date: DateTime.parse(json['date']),
    );
  }
}
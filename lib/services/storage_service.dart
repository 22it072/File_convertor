import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_converter/models/conversion_history.dart';
import 'dart:convert';

class StorageService {
  static const _historyKey = 'conversion_history';

  static Future<List<ConversionHistory>> getConversionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];
    return historyJson
        .map((json) => ConversionHistory.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> saveConversionHistory(ConversionHistory item) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getConversionHistory();
    history.add(item);
    await prefs.setStringList(
      _historyKey,
      history.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }

  static Future<void> deleteHistoryItem(ConversionHistory item) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getConversionHistory();
    history.removeWhere((h) => h.inputPath == item.inputPath && h.date == item.date);
    await prefs.setStringList(
      _historyKey,
      history.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }
}
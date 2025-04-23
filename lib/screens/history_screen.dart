import 'package:flutter/material.dart';
import 'package:file_converter/models/conversion_history.dart';
import 'package:file_converter/services/storage_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ConversionHistory> historyItems = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final items = await StorageService.getConversionHistory();
    setState(() {
      historyItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
      ),
      body: historyItems.isEmpty
          ? const Center(child: Text('No conversion history yet'))
          : ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text('${item.fromFormat} to ${item.toFormat}'),
            subtitle: Text(item.date.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await StorageService.deleteHistoryItem(item);
                _loadHistory();
              },
            ),
          );
        },
      ),
    );
  }
}
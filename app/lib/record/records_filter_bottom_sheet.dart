import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordsFilterBottomSheet extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final void Function(DateTimeRange?) onFilterApplied;

  const RecordsFilterBottomSheet({
    super.key,
    required this.initialDateRange,
    required this.onFilterApplied,
  });

  @override
  State<RecordsFilterBottomSheet> createState() =>
      _RecordsFilterBottomSheetState();
}

class _RecordsFilterBottomSheetState extends State<RecordsFilterBottomSheet> {
  DateTimeRange? _tempDateRange;

  @override
  void initState() {
    super.initState();
    _tempDateRange = widget.initialDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Filter by date",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            icon: const Icon(Icons.date_range),
            label: Text(
              _tempDateRange == null
                  ? "Select date range"
                  : "${DateFormat.yMMMd().format(_tempDateRange!.start)} → ${DateFormat.yMMMd().format(_tempDateRange!.end)}",
            ),
            onPressed: _pickDateRange,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  widget.onFilterApplied(null);
                  Navigator.pop(context);
                },
                child: const Text("Clear"),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onFilterApplied(_tempDateRange);
                  Navigator.pop(context);
                },
                child: const Text("Apply"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5);
    final lastDate = DateTime(now.year + 1);

    final picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: _tempDateRange,
    );

    if (picked != null) {
      setState(() {
        _tempDateRange = picked;
      });
    }
  }
}

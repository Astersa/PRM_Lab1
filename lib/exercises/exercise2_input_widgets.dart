import 'package:flutter/material.dart';

class Exercise2Screen extends StatefulWidget {
  const Exercise2Screen({super.key});

  @override
  State<Exercise2Screen> createState() => _Exercise2ScreenState();
}

class _Exercise2ScreenState extends State<Exercise2Screen> {
  double _sliderValue = 50;
  bool _switchValue = false;
  String _selectedOption = 'Option A';
  DateTime? _selectedDate;

  final List<String> _radioOptions = ['Option A', 'Option B', 'Option C'];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2: Input Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Slider
          Text('Slider value: ${_sliderValue.toInt()}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: _sliderValue.toInt().toString(),
            onChanged: (v) => setState(() => _sliderValue = v),
          ),
          const Divider(),

          // Switch
          SwitchListTile(
            title: const Text('Enable Feature'),
            subtitle: Text(_switchValue ? 'On' : 'Off'),
            value: _switchValue,
            onChanged: (v) => setState(() => _switchValue = v),
          ),
          const Divider(),

          // RadioListTile group
          const Text('Select an option:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          ..._radioOptions.map(
            (opt) => RadioListTile<String>(
              title: Text(opt),
              value: opt,
              // ignore: deprecated_member_use
              groupValue: _selectedOption,
              // ignore: deprecated_member_use
              onChanged: (v) => setState(() => _selectedOption = v!),
            ),
          ),
          const Divider(),

          // DatePicker
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(_selectedDate == null
                ? 'Pick a date'
                : 'Selected: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
            trailing: ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Choose'),
            ),
          ),
          const Divider(),

          // Summary
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Summary',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Slider: ${_sliderValue.toInt()}'),
                  Text('Switch: $_switchValue'),
                  Text('Radio: $_selectedOption'),
                  Text(
                    'Date: ${_selectedDate?.toLocal().toString().split(' ')[0] ?? "none"}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

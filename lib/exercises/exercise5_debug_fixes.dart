import 'package:flutter/material.dart';

// Exercise 5: Debug & Fix Common UI Errors
//
// Fix 1: ListView inside Column — wrap with Expanded so ListView gets bounded height.
// Fix 2: Content overflow — wrap body with SingleChildScrollView.
// Fix 3: State update — call setState() to trigger rebuild.
// Fix 4: DatePicker context error — use a stored BuildContext or ensure widget is
//         still mounted before calling showDatePicker.

class Exercise5Screen extends StatefulWidget {
  const Exercise5Screen({super.key});

  @override
  State<Exercise5Screen> createState() => _Exercise5ScreenState();
}

class _Exercise5ScreenState extends State<Exercise5Screen> {
  int _tapCount = 0;
  DateTime? _pickedDate;

  Future<void> _pickDate(BuildContext ctx) async {
    // Fix 4: use the local ctx captured at call site, not a stale context.
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && mounted) {
      setState(() => _pickedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5: Debug Fixes')),
      // Fix 2: SingleChildScrollView prevents overflow when keyboard appears
      // or content exceeds screen height.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fix 1: ListView inside Column',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Fix 1: SizedBox with a fixed height (or Expanded in a Scaffold body)
            // gives ListView a bounded constraint.
            SizedBox(
              height: 150,
              child: ListView(
                children: const [
                  ListTile(title: Text('Item 1')),
                  ListTile(title: Text('Item 2')),
                  ListTile(title: Text('Item 3')),
                  ListTile(title: Text('Item 4')),
                ],
              ),
            ),
            const Divider(height: 32),

            const Text(
              'Fix 3: setState() rebuilds UI',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Tap count: $_tapCount'),
            const SizedBox(height: 8),
            ElevatedButton(
              // Fix 3: Without setState the counter variable changes but the UI
              // does not know it needs to rebuild.
              onPressed: () => setState(() => _tapCount++),
              child: const Text('Increment'),
            ),
            const Divider(height: 32),

            const Text(
              'Fix 4: DatePicker with correct context',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _pickedDate == null
                  ? 'No date selected'
                  : 'Selected: ${_pickedDate!.toLocal().toString().split(' ')[0]}',
            ),
            const SizedBox(height: 8),
            // Builder provides a fresh context that is definitely below Scaffold.
            Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => _pickDate(ctx),
                child: const Text('Pick Date'),
              ),
            ),
            const Divider(height: 32),

            // Fix 2 demo: lots of content that would overflow without scroll
            const Text(
              'Fix 2: SingleChildScrollView prevents overflow',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              20,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('Content row ${i + 1} — no overflow thanks to scroll'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

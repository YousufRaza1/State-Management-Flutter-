import 'package:flutter/material.dart';

// Step 1: Create the CounterNotifier class
class CounterNotifier extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();  // Notify listeners of the change
  }
}

// Step 2: Create InheritedNotifier to wrap CounterNotifier
class CounterInheritedNotifier extends InheritedNotifier<CounterNotifier> {
  const CounterInheritedNotifier({
    Key? key,
    required CounterNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static CounterInheritedNotifier? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedNotifier>();
  }
}

// Step 3: Main app widget
class InheritedNotifierExample extends StatefulWidget {
  @override
  _InheritedNotifierExampleState createState() => _InheritedNotifierExampleState();
}

class _InheritedNotifierExampleState extends State<InheritedNotifierExample> {
  final CounterNotifier counterNotifier = CounterNotifier();  // Create the notifier

  @override
  Widget build(BuildContext context) {
    return CounterInheritedNotifier(
      notifier: counterNotifier,
      child: Scaffold(
        appBar: AppBar(title: Text("InheritedNotifier Example")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterDisplay(),  // Widget that displays the counter
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                counterNotifier.increment();  // Increment the counter
              },
              child: Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}

// Step 4: Create CounterDisplay widget
class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the notifier from CounterInheritedNotifier
    final counterNotifier = CounterInheritedNotifier.of(context)?.notifier;

    return Center(
      child: Text(
        'Counter: ${counterNotifier?.counter ?? 0}',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

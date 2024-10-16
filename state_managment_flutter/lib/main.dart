import 'dart:ffi';

import 'package:flutter/material.dart';
import 'CounterInheritedWidget.dart';
import 'example_change_notifier.dart';
import 'state_management_using_provider/View/counter_main_screen.dart';

void main() {
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CounterMainScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final viewModel = Counter();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ValueListenableBuilder<int>(
                valueListenable: viewModel.count,
                builder: (BuildContext context, int value, child) {
                  return Text('$value');
                }
            ),
            ValueListenableBuilder<List<Student>>(
              valueListenable: viewModel.studentList,
              builder: (BuildContext context, List<Student> list, child) {
                return Text('${list.length}');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleButtonAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  handleButtonAction() {
    viewModel.incrementCount();
    viewModel.addNewStudnet();
  }
}


class Counter {
  final ValueNotifier<int> count = ValueNotifier<int>(0);
  final ValueNotifier<List<Student>> studentList = ValueNotifier<List<Student>>([]);

  void incrementCount() {
    count.value++;
  }
  void addNewStudnet() {
    final newStudent = Student(name: "Razu",age: 12);
    studentList.value = List.from(studentList.value)..add(newStudent);

  }
}

class Student {
  String name = "Yousuf";
  double age = 10.5;
  Student({required this.name, required this.age});
}
// Step 1: Create the InheritedWidget
import 'package:flutter/material.dart';
class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final Widget child;
  final Function() increment;

  CounterInheritedWidget({
    Key? key,
    required this.counter,
    required this.child,
    required this.increment,
  }) : super(key: key, child: child);

  // Helper method to access the widget from any descendant
  static CounterInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
  }

  // Determines whether descendants should rebuild if this widget is updated
  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}


class InheritedWidgetExample extends StatefulWidget {
  const InheritedWidgetExample({super.key});


  @override
  State<InheritedWidgetExample> createState() => _InheritedWidgetExampleState();
}

class _InheritedWidgetExampleState extends State<InheritedWidgetExample> {

  int counter =5;

  void incrementCounter() {
   setState(() {
     counter ++;
   });
  }

  @override
  Widget build(BuildContext context) {
    final int? counter = CounterInheritedWidget.of(context)?.counter;
    return SafeArea(
        child: Center(
          child: CounterInheritedWidget(
              counter: 5,
              increment: incrementCounter,
              child: Column(
                children: [
                  Text('${counter ?? 0}'),
                  SecondChildren()

                ],
              ),
          ),
        )
    );
  }
}

class SecondChildren extends StatefulWidget {
  const SecondChildren({super.key});

  @override
  State<SecondChildren> createState() => _SecondChildrenState();
}

class _SecondChildrenState extends State<SecondChildren> {
  @override
  Widget build(BuildContext context) {
    final CounterInheritedWidget myWidget = CounterInheritedWidget.of(context)!;
    return  Column(
      children: [
        TextButton(
            onPressed: myWidget.increment,
            child: Text('increase')
        ),
        Text('${myWidget.counter ?? 0}')
      ],
    );
  }
}





// Step 1: Create the InheritedModel
class UserModelInheritedModel extends InheritedModel<String> {
  final String name;
  final int age;

  UserModelInheritedModel({
    Key? key,
    required this.name,
    required this.age,
    required Widget child,
  }) : super(key: key, child: child);

  static UserModelInheritedModel? of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<UserModelInheritedModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(UserModelInheritedModel oldWidget) {
    return name != oldWidget.name || age != oldWidget.age;
  }

  @override
  bool updateShouldNotifyDependent(
      UserModelInheritedModel oldWidget, Set<String> dependencies) {
    if (dependencies.contains('name') && name != oldWidget.name) {
      return true;
    }
    if (dependencies.contains('age') && age != oldWidget.age) {
      return true;
    }
    return false;
  }
}

// Step 2: Create the Parent Widget
class InheritedModelExample extends StatefulWidget {
  @override
  _InheritedModelExampleState createState() => _InheritedModelExampleState();
}

class _InheritedModelExampleState extends State<InheritedModelExample> {
  String name = "John";
  int age = 25;

  void changeName() {
    setState(() {
      name = "Alice";
    });
  }

  void changeAge() {
    setState(() {
      age++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserModelInheritedModel(
      name: name,
      age: age,
      child: Scaffold(
        appBar: AppBar(title: Text("InheritedModel Example")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NameWidget(),
            AgeWidget(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: changeName,
              child: Text('Change Name'),
            ),
            ElevatedButton(
              onPressed: changeAge,
              child: Text('Increment Age'),
            ),
          ],
        ),
      ),
    );
  }
}

// Step 3: Create the Child Widgets
class NameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userModel = UserModelInheritedModel.of(context, 'name');
    return Text(
      'Name: ${userModel?.name ?? ''}',
      style: TextStyle(fontSize: 24),
    );
  }
}

class AgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userModel = UserModelInheritedModel.of(context, 'age');
    return Text(
      'Age: ${userModel?.age ?? 0}',
      style: TextStyle(fontSize: 24),
    );
  }
}
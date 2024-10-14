import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/counter_view_model.dart';

class CounterMainScreen extends StatefulWidget {
  const CounterMainScreen({super.key});

  @override
  State<CounterMainScreen> createState() => _CounterMainScreenState();
}

class _CounterMainScreenState extends State<CounterMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CounterViewModel(),
        child: Consumer<CounterViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            floatingActionButton: ElevatedButton(
              onPressed: () {
                viewModel.addNewElementInList();
              },
              child: Text('Add new'),
            ),
            appBar: AppBar(
              backgroundColor: Colors.greenAccent,
            ),
            body: SafeArea(
              child: Center(
                child: Consumer<CounterViewModel>(
                  builder: (context, viewModel, child) {
                    return Column(
                      children: [
                        // Wrap ListView.builder in an Expanded widget
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.listOfNumber.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  viewModel.listOfNumber[index].toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> CountNextScreen(viewModel: viewModel))
                              );
                            },
                            child: Text('Go to next screen')
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );

        }));
  }
}


class CountNextScreen extends StatefulWidget {
  final CounterViewModel viewModel;

  CountNextScreen({super.key, required this.viewModel});

  @override
  State<CountNextScreen> createState() => _CountNextScreenState();
}

class _CountNextScreenState extends State<CountNextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: (){
            widget.viewModel.addNewElementInList();
          },
          child: Text('add new element')
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        // Accessing the length of listOfNumber from the passed viewModel
        child: Text(
          'Number of items: ${widget.viewModel.listOfNumber.length}', // Accessing the list length here
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
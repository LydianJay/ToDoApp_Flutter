import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _text = TextEditingController();
  List<String> task = [];
  List<DateTime> time = [];
  Future<void> _addTaskDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              controller: _text,
              maxLines: 2,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2069, 1, 1, 1),
                  ).then((TimeChoosen) {
                    setState(() {
                      task.add(_text.text);
                      time.add(TimeChoosen!);
                      _text.clear();
                    });
                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Create Task'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Back'),
              ),
            ],
          );
        });
  }

  List<Widget> _listTask(double scrHeight, double scrWidth) {
    List<Widget> r = [];

    int i = 0;

    for (var t in task) {
      r.add(
        Container(
          width: scrWidth * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    task.removeWhere((element) => element == t);
                  });
                },
                icon: const Icon(Icons.delete),
              ),
              Text(
                t,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(time[i].toLocal().toString()),
            ],
          ),
        ),
      );
      i++;
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: scrHeight * 0.1,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'To Do List',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              children: _listTask(scrHeight, scrWidth),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:contact_diary/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Consumer<CounterProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return Text(
              "${value.count}",
              style: TextStyle(fontSize: 50),
            );
          },
        ),
      ),
      floatingActionButton: Consumer<CounterProvider>(
        builder: (context, value, child) => FloatingActionButton(
          onPressed: () {
            value.increment();
          },
        ),
      ),
    );
  }
}

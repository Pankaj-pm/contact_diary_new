import 'package:contact_diary/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Column(
        children: [
          Consumer<CounterProvider>(
            builder: (BuildContext context, value, Widget? child) => Text(
              "${value.count}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          ElevatedButton(onPressed: () {
            Provider.of<CounterProvider>(context,listen: false).increment();
          }, child: Text("Click"))
        ],
      ),
    );
  }
}

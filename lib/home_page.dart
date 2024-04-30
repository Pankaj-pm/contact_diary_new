import 'package:contact_diary/counter_provider.dart';
import 'package:contact_diary/detail_page.dart';
import 'package:contact_diary/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getInt("themeMode");
      print("My Save Val $themeMode");
      Provider.of<ThemeProvider>(context,listen: false).changeTheme(themeMode??0);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Consumer<CounterProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Text(
                "${value.count}",
                style: TextStyle(fontSize: 50),
              );
            },
          ),
          TextFormField(
            controller: controller,
            onChanged: (value) {
              var text = controller.text;
              var intVal = int.tryParse(text);
              Provider.of<CounterProvider>(context, listen: false).changeVal(intVal ?? 0);
            },
          ),
          ElevatedButton(
            onPressed: () {
              var text = controller.text;
              var intVal = int.tryParse(text);
              Provider.of<CounterProvider>(context, listen: false).changeVal(intVal ?? 0);
            },
            child: Text("Ok"),
          ),
          Consumer<ThemeProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return DropdownButton(
                value: value.themeMode,
                items: [
                  DropdownMenuItem(child: Text("System"), value: 0),
                  DropdownMenuItem(child: Text("Light"), value: 1),
                  DropdownMenuItem(child: Text("Dark"), value: 2),
                ],
                onChanged: (value) async{
                  var instance = await SharedPreferences.getInstance();
                  instance.setInt("themeMode", value ?? 0);

                  Provider.of<ThemeProvider>(context, listen: false).changeTheme(value ?? 0);
                  print("value $value");
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(),
                ),
              );
            },
            child: Icon(Icons.send),
          ),
          FloatingActionButton(
            heroTag: "0",
            onPressed: () {
              Provider.of<CounterProvider>(context, listen: false).increment();
            },
          ),
        ],
      ),
    );
  }
}

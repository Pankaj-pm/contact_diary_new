import 'package:contact_diary/controller/contact_provider.dart';
import 'package:contact_diary/controller/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  int? index;

  DetailPage({super.key, this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(widget.index!=null){
      var nameVal = Provider.of<ContactProvider>(context,listen: false).contactList[widget.index!].name??"";
      var numberVal = Provider.of<ContactProvider>(context,listen: false).contactList[widget.index!].number??"";
      name.text=nameVal;
      number.text=numberVal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index != null ? "Edit" : "Add"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: InputDecoration(hintText: "Name"),
          ),
          TextFormField(
            controller: number,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: "Number"),
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.index != null) {
                  Provider.of<ContactProvider>(context, listen: false).editContact(
                    widget.index!,
                    name.text,
                    number.text,
                  );
                } else {
                  Provider.of<ContactProvider>(context, listen: false).addContact(
                    name.text,
                    number.text,
                  );
                }

                Navigator.pop(context);
              },
              child: Text(widget.index != null ? "Edit" : "Add"))
        ],
      ),
    );
  }
}

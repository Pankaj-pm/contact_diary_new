import 'package:contact_diary/controller/contact_provider.dart';
import 'package:contact_diary/model/contact_model.dart';
import 'package:contact_diary/view/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          return ListView.builder(
            itemCount: value.contactList.length,
            itemBuilder: (context, index) {
              ContactModel contact = value.contactList[index];

              return ListTile(
                leading: CircleAvatar(child: Text("${contact.name ?? ""}"[0].toUpperCase())),
                title: Text(contact.name ?? ""),
                subtitle: Text(contact.number ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(index: index,);
                          },
                        ));
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<ContactProvider>(context, listen: false).deleteContact(index);
                      },
                      icon: Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {

                        String con='Please Use this number ${contact.name ?? ""},${contact.number ?? ""} ';
                        Share.share(con);
                      },
                      icon: Icon(Icons.share),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPage();
            },
          ));
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}

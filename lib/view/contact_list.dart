import 'package:contact_diary/controller/contact_provider.dart';
import 'package:contact_diary/model/contact_model.dart';
import 'package:contact_diary/view/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
                leading: InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("tel:+1-555-010-999"));
                  },
                  child: CircleAvatar(
                    child: Text("${contact.name ?? ""}"[0].toUpperCase()),
                  ),
                ),
                title: Text(contact.name ?? ""),
                subtitle: Text(contact.number ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [



                    PopupMenuButton(
                      child: Icon(Icons.add),
                      tooltip: "",
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("Delete"),
                            onTap: () {
                              Provider.of<ContactProvider>(context, listen: false).deleteContact(index);
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Share"),
                            onTap: () {
                              String con = 'Please Use this number ${contact.name ?? ""},${contact.number ?? ""} ';
                              Share.share(con);
                            },
                          ),
                          PopupMenuItem(
                            child: Text("Edit"),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(
                                    index: index,
                                  );
                                },
                              ));
                            },
                          ),
                        ];
                      },
                    )
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

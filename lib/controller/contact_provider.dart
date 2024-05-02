import 'package:contact_diary/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  void addContact(String name, String number) {
    contactList.add(ContactModel(name: name, number: number));
    notifyListeners();
  }

  void deleteContact(int index){
    contactList.removeAt(index);
    notifyListeners();
  }

  void editContact(int index,String name, String number){
    contactList[index]=ContactModel(name: name,number: number);
    notifyListeners();
  }
}

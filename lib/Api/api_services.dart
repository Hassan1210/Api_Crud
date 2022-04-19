import 'dart:convert';

import 'package:http/http.dart' as http;

import 'modle.dart';

class ContactApi {
  save(Contact contact) async {
    try {
      var response = await http.post(
          Uri.parse("https://abc.sketchwithme.tk/api/create.php"),
          body:jsonEncode({
            'name': contact.name,
            'phone': contact.phone
          }));
        print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  getData() async {
    try {
      var response =
          await http.get(Uri.parse("https://abc.sketchwithme.tk/api/read.php"));
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        if (data['status'] == true) {
          List contact = data["data"];
          return contact.map((e) => Contact.fromMap(e)).toList();
        }
        List<Contact> x = [];
        return x;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  delete(int? id) async {
    try {
      var response = await http.delete(
          Uri.parse("https://abc.sketchwithme.tk/api/delete.php"),
          body:jsonEncode({
            'id': id,
          }));
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
  update(Contact contact) async {
    try {
      var response = await http.put(
          Uri.parse("https://abc.sketchwithme.tk/api/update.php"),
          body:jsonEncode({
            'id': contact.id,
            'name':contact.name,
            'phone':contact.phone,
          }));
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}

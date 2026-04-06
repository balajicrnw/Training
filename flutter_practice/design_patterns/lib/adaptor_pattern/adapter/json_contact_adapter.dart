import 'dart:convert';
import '../api/json_api.dart';
import '../model/contact.dart';
import 'contact_adapter.dart';

class JsonContactAdapter implements ContactAdapter {
  final JsonApi api;

  JsonContactAdapter(this.api);

  @override
  List<Contact> getContacts() {
    final raw = api.getData();
    final List data = json.decode(raw);

    return data.map((e) {
      return Contact(
        name: e['name'],
        email: e['email'],
      );
    }).toList();
  }
}
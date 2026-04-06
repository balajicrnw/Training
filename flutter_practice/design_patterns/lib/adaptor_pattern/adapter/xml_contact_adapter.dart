
import 'package:xml/xml.dart';
import '../api/xml_api.dart';
import '../model/contact.dart';
import 'contact_adapter.dart';

class XmlContactAdapter implements ContactAdapter {
  final XmlApi api;

  XmlContactAdapter(this.api);

  @override
  List<Contact> getContacts() {
    final raw = api.getData();
    final document = XmlDocument.parse(raw);

    final contacts = <Contact>[];

    for (final node in document.findAllElements('contact')) {
      final name = node.findElements('name').single.text;
      final email = node.findElements('email').single.text;

      contacts.add(Contact(name: name, email: email));
    }

    return contacts;
  }
}
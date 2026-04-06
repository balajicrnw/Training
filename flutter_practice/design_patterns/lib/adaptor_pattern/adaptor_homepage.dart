import 'package:design_patterns/adaptor_pattern/api/xml_api.dart';
import 'package:design_patterns/adaptor_pattern/model/contact.dart';
import 'package:flutter/material.dart';
import 'adapter/contact_adapter.dart';
import 'adapter/json_contact_adapter.dart';
import 'adapter/xml_contact_adapter.dart';
import 'api/json_api.dart';

class AdaptorHomepage extends StatefulWidget {
  const AdaptorHomepage({super.key});

  @override
  State<AdaptorHomepage> createState() => _AdaptorHomepageState();
}

class _AdaptorHomepageState extends State<AdaptorHomepage> {
  List<Contact> contacts = [];

  void loadJson() {
    final adapter = JsonContactAdapter(JsonApi());
    setState(() {
      contacts = adapter.getContacts();
    });
  }

  void loadXml() {
    final adapter = XmlContactAdapter(XmlApi());
    setState(() {
      contacts = adapter.getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adapter Pattern")),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: loadJson,
                child: const Text("Load JSON"),
              ),
              ElevatedButton(
                onPressed: loadXml,
                child: const Text("Load XML"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final c = contacts[index];
                return ListTile(
                  title: Text(c.name),
                  subtitle: Text(c.email),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
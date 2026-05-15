import 'package:flutter/material.dart';
import 'package:serverpod_practice_backend_client/serverpod_practice_backend_client.dart';

var client = Client('http://localhost:8080/');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonScreen(),
    );
  }
}

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final colorController = TextEditingController();
  final professionController = TextEditingController();

  List<Person> persons = [];

  @override
  void initState() {
    super.initState();
    loadPersons();
  }

  Future<void> loadPersons() async {
    final response = await client.person.getPersons();

    setState(() {
      persons = response;
    });
  }

  Future<void> addPerson() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        cityController.text.isEmpty ||
        colorController.text.isEmpty ||
        professionController.text.isEmpty) {
      return;
    }

    await client.person.addPerson(
      nameController.text,
      int.parse(ageController.text),
      cityController.text,
      colorController.text,
      professionController.text,
    );

    nameController.clear();
    ageController.clear();
    cityController.clear();
    colorController.clear();
    professionController.clear();

    loadPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serverpod Users'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: colorController,
              decoration: const InputDecoration(
                labelText: 'Favorite Color',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: professionController,
              decoration: const InputDecoration(
                labelText: 'Profession',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: addPerson,
                child: const Text(
                  'Add User',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: persons.isEmpty
                  ? const Center(
                      child: Text(
                        'No users registered',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text('Name'),
                          ),

                          DataColumn(
                            label: Text('Age'),
                          ),

                          DataColumn(
                            label: Text('City'),
                          ),

                          DataColumn(
                            label: Text('Color'),
                          ),

                          DataColumn(
                            label: Text('Profession'),
                          ),
                        ],

                        rows: persons.map((person) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(person.name),
                              ),

                              DataCell(
                                Text(person.age.toString()),
                              ),

                              DataCell(
                                Text(person.city),
                              ),

                              DataCell(
                                Text(person.favoriteColor),
                              ),

                              DataCell(
                                Text(person.profession),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

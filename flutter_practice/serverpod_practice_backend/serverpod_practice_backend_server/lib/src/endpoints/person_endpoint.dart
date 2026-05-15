import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class PersonEndpoint extends Endpoint {
  Future<Person> addPerson(
    Session session,
    String name,
    int age,
    String city,
    String favoriteColor,
    String profession,
  ) async {
    final person = Person(
      name: name,
      age: age,
      city: city,
      favoriteColor: favoriteColor,
      profession: profession,
    );

    await Person.db.insertRow(
      session,
      person,
    );

    return person;
  }

  Future<List<Person>> getPersons(
    Session session,
  ) async {
    return await Person.db.find(
      session,
    );
  }
}

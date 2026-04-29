import 'package:rxdart/rxdart.dart';

void main() {
  final subject = ReplaySubject<int>();

  // First listener
  subject.listen((value) {
    print("Listener 1: $value");
  });

  subject.add(10);
  subject.add(20);

  // Second listener joins late
  subject.listen((value) {
    print("Listener 2: $value");
  });

  //it also gives the previous values to the new listener

  subject.add(30);

  subject.close();
}

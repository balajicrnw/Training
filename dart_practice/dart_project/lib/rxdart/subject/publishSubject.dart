import 'package:rxdart/rxdart.dart';

void main() {
  final subject = PublishSubject<int>();

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

  // it waits for the next value to be added 30

  subject.add(30);

  subject.close();
}

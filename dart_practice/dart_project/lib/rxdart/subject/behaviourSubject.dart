import 'package:rxdart/rxdart.dart';

void main() {
  final subject = BehaviorSubject<int>();

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

  //no waiting it gets the previous value 20
  subject.add(30);

  subject.close();
}

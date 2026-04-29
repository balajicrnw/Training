import 'package:rxdart/rxdart.dart';
import 'dart:async';

void main() async {
  final intStream = Stream.fromIterable([1, 2, 2, 3, 1, 4]);

  // prints the distinct values from the stream

  intStream.distinct().listen((value) {
    print(value);
  });

  // reduce is used to reduce the values from the stream to a single value

  await intStream.reduce((a, b) => a + b).then((value) {
    print(value);
  });

  // debounceTime is used to wait for the specified time before printing the value
  // if the next value is added before the specified time then the timer resets

  final controller = StreamController<int>();

  controller.stream.debounceTime(Duration(milliseconds: 500)).listen((value) {
    print("FINAL OUTPUT: $value");
  });

  Timer(Duration(milliseconds: 0), () => controller.add(10));
  Timer(Duration(milliseconds: 200), () => controller.add(20));

  // 200+400 time exceeded so it prints
  Timer(Duration(milliseconds: 400), () => controller.add(30));
  // it gets reset after adding this value
  Timer(Duration(milliseconds: 100), () => controller.add(40));

  Timer(Duration(seconds: 2), () => controller.close());
}

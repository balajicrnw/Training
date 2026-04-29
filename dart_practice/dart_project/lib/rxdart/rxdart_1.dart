import 'package:rxdart/rxdart.dart';

void main() {
  final stream = Stream.fromIterable([1, 2, 3, 4]);

  // filter the values in the stream

  stream
      .where((value) => value % 2 == 0)
      .listen((value) => print("filter: $value"));

  //transform the values in the stream

  stream.map((value) => value * 10).listen((value) => print("map: $value"));

  // take the first 2 values from the stream

  stream.take(2).listen((value) => print("take: $value"));

  // map returns the stream objects since it have a nested stream
  stream
      .map((value) {
        return Stream.fromIterable([value, value * 10]);
      })
      .listen((value) {
        print(value);
      });

  // flatMap returns the values directly since it have a nested stream

  stream
      .flatMap((value) {
        return Stream.fromIterable([value, value * 10]);
      })
      .listen((value) {
        print(value);
      });
}

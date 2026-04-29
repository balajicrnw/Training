import 'package:rxdart/rxdart.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([10, 20, 30]);

  // first streams runs after that second stream runs

  Rx.concat([stream1, stream2]).listen((value) {
    print(value);
  });

  // combine latest values from both streams

  Rx.combineLatest2(stream1, stream2, (a, b) => a + b).listen((value) {
    print(value);
  });

  // // zip combines the values from both streams using index

  Rx.zip2(stream1, stream2, (a, b) => a + b).listen((value) {
    print(value);
  });

  // build the result using the previous value

  stream1.scan((i, v, index) => i + v, 0).listen((value) {
    print(value);
  });

  // merge is used to merge the values from both streams

  Rx.merge([stream1, stream2]).listen((value) {
    print(value);
  });

  // bufferCount is used to buffer the values from the stream

  final stream3 = Stream.fromIterable([1, 2, 3, 4, 5, 6]);

  stream3.bufferCount(3).listen((value) {
    print(value);
  });

  // bufferTime is used to buffer the values from the stream based on the time

  Stream.periodic(
    Duration(milliseconds: 400),
    (i) => i + 1,
  ).take(10).bufferTime(Duration(seconds: 2)).listen(print);
}

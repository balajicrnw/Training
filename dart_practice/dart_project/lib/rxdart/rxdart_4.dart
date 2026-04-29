import 'dart:async';
import 'package:rxdart/rxdart.dart';

void main() {
  // takeUntil is used to stop the stream after the specified time

  final source = Stream.periodic(Duration(milliseconds: 800), (i) => i);

  final stopSignal = Stream<void>.fromFuture(
    Future.delayed(Duration(seconds: 5)),
  );

  source.takeUntil(stopSignal).listen((value) {
    print("VALUE: $value");
  });

  // defaultIfEmpty is used to print the default value if the stream is empty

  final emptyStream = Stream<int>.empty();

  emptyStream.defaultIfEmpty(100).listen((value) {
    print("VALUE: $value");
  });
}

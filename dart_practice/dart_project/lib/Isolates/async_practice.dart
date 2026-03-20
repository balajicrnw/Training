import 'dart:async';
void main() {
  print("1");

  scheduleMicrotask(() => print("2"));

  Future.microtask(() => print("3"));

  Future(() => print("4"));

  Future.delayed(Duration.zero, () => print("5"));

  Future.value("6").then(print);

  Future.sync(() => print("7"));

  print("8");
}
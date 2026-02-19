import 'dart:io';

int add(int a, int b) => a + b;
int sub(int a, int b) => a - b;

void main() {
  String input = stdin.readLineSync()!;
  List<String> parts = input.split(",");

  int a = int.parse(parts[0].trim());
  int b = int.parse(parts[1].trim());

  print("Choose operation: add / sub");
  String op = stdin.readLineSync()!.toLowerCase();

  switch (op) {
    case "add":
      print(add(a, b));
      break;

    case "sub":
      print(sub(a, b));
      break;

    default:
      print("Invalid operation");
  }
}

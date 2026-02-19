Future<void> main() async{
  print("Briyani Cokking");
  await Future.delayed(Duration(seconds: 3));
  print("Cutting the vegetables");
  await Future.delayed(Duration(seconds: 2));
  print("Washing chicken");
  await Future.delayed(Duration(seconds: 2));
  print("Turning on the stove");
  await Future.delayed(Duration(seconds: 2));
  print("adding items to cooker");
  await Future.delayed(Duration(seconds: 5));
  print("Whistle 1");
  await Future.delayed(Duration(seconds: 3));
  print("Whistle 2");
  await Future.delayed(Duration(seconds: 3)); 
  print("Whistle 3");
  await Future.delayed(Duration(seconds: 3));
  print("Wait dont touch let the pressure release");
  await Future.delayed(Duration(seconds: 5));
  print("Now open and eat the Briyani");
}
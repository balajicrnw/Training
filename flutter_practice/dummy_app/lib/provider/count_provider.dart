import 'package:flutter/widgets.dart';

class CountProvider extends ChangeNotifier {
  int count=0;
  String name="";

  CountProvider({this.count=0,this.name="Batman"});

  void changeName(String name){
    this.name=name;
    notifyListeners();
  }

  void increment(){
    count++;
    notifyListeners();
  }
  void decrement(){
    count--;
    notifyListeners();
  }
}

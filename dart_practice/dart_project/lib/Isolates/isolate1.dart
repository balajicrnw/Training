
import 'dart:async';

void main(){
  print("Start");
  Future((){
    print("future task");
  });
  Future.microtask(()=>print("microtask1"));
  scheduleMicrotask(()=>print("scheduledmicrotask"));
  Future.microtask(()=>print("microtask2"));

  print("End");
}
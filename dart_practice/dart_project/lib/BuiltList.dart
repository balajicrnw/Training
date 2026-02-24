import 'package:built_collection/built_collection.dart';
void main(){
  var list=new BuiltList<int>([1,2,3,4]);
  var builder=list.toBuilder();
  print(builder);
  builder.add(5);
  print(list);
  var newList=builder.build();
  print(newList);
  
}
  

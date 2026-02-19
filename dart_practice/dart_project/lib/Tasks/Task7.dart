double? calculations({double? speed,double? time,double? distance}){
  double result=0;
  if(speed==null && time!=null && distance!=null){
    result=distance/time;
  }
  else if(time==null && speed!=null && distance!=null){
    result=distance/speed;
  }
  else if(distance==null && speed!=null && time!=null){
    result=speed*time;
  }
  
  return result;
}
void main(){
  double? result=calculations(speed: 50,distance: 100);
  print(result);
}
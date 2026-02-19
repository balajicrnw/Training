enum Vacinated{
  Vaccinated,
  NotVaccinated
}
class Animal{
  int no_of_legs;
  int age;
  String name;

  Animal(this.no_of_legs,this.age,this.name);
}
class Dog extends Animal{
  String Ownername;
  Vacinated Vaccined;
  Dog(int no_of_legs,int age,String species,this.Ownername,this.Vaccined):super(no_of_legs,age,species);

  String toString(){
    return"$name is a Dog of age $age is owned by $Ownername and is ${Vaccined.name}";
  }

}

void main(){
  Dog d1=new Dog(4,10,"Derry","Balaji",Vacinated.Vaccinated);

  print(d1);
}
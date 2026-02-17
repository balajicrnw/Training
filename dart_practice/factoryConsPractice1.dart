class VehicaleFuel{
  static double fuelCapcity=50;
  double curretFuel;
  double Fuelneeded;

  VehicaleFuel.fillFuel(this.Fuelneeded,this.curretFuel);

  factory VehicaleFuel(double fuelNeeded, double curretFuel){
    if((fuelNeeded+curretFuel)>50){
      print("Fuel fulled $fuelCapcity liters. Cannot add more fuel. remaining fuel: ${fuelNeeded+curretFuel-fuelCapcity} liters");
      return VehicaleFuel.fillFuel(0,50);
    } else {
      print("Fuel fulled $fuelNeeded liters. Total fuel: ${fuelNeeded+curretFuel} liters");
      return VehicaleFuel.fillFuel(fuelNeeded,curretFuel);
    }
  }
}

void main(){
  VehicaleFuel v1=VehicaleFuel(30, 10);
  VehicaleFuel v2=VehicaleFuel(25, 20);
  VehicaleFuel v3=VehicaleFuel(15, 5);
  VehicaleFuel v4=VehicaleFuel(100, 40);
}
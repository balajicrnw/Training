abstract class Bottle{
  double? quantity;
  double? sugarQuantity;
  String? companyName;

  void open();
}

class CocaCola implements Bottle{
  @override
  double? quantity;
  @override
  double? sugarQuantity;
  @override
  String? companyName;

  CocaCola(this.quantity,this.sugarQuantity,this.companyName);

  @override
  void open(){
    print("Coca Cola Opened");
  }
}

class Pepsi implements Bottle{
  @override
  double? quantity;
  @override
  double? sugarQuantity;
  @override
  String? companyName; 

  Pepsi(this.quantity,this.sugarQuantity,this.companyName);



  @override
  void open(){
    print("Pepsi Opened");
  }
}

class Sprite implements Bottle{
  @override
  double? quantity;
  @override
  double? sugarQuantity;
  @override
  String? companyName;  

  Sprite(this.quantity,this.sugarQuantity,this.companyName);

  @override
  void open(){
    print("Sprite Opened");
  }
}

void main(){
  CocaCola cocaCola=CocaCola(100,85,"Coca Cola");
  cocaCola.open();

  Pepsi pepsi=Pepsi(100,80,"Pepsi");
  pepsi.open();

  Sprite sprite=Sprite(100,95,"Coca Cola");
  sprite.open();
}
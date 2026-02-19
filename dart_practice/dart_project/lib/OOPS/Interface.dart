abstract class Printer{
  bool? colorprint;
  bool? scanner;
  int? price;
  int? warrenty;
  bool? wireless;
  void displayPrinterinfo();
  void paperprint();
  void paperscan();
}

class HPPrinter implements Printer{

  @override
  bool? colorprint=true;
  
  @override
  int? price=10000;
  
  @override
  bool? scanner=true;
  
  @override
  int? warrenty=5;
  
  @override
  bool? wireless=true;

  @override
  void displayPrinterinfo(){
    print("Color Print: $colorprint");
    print("Scanner: $scanner");
    print("Price: $price");
    print("Warrenty: $warrenty");
    print("Wireless: $wireless");
  }

  @override
  void paperprint(){
    print("Paper is printing...");
    print("paper printed in color");
  }

  @override
  void paperscan(){
    print("Paper is scanning...");
  }
}

class CanonPrinter implements Printer{

  @override
  bool? colorprint=false;
  
  @override
  int? price=5000;
  
  @override
  bool? scanner=false;
  
  @override
  int? warrenty=2;
  
  @override
  bool? wireless=false;

  @override
  void displayPrinterinfo(){
    print("Color Print: $colorprint");
    print("Scanner: $scanner");
    print("Price: $price");
    print("Warrenty: $warrenty");
    print("Wireless: $wireless");
  }

  @override
  void paperprint(){
    print("Paper is printing...");
    print("paper printed in black and white");
  }

  @override
  void paperscan(){
    print("Scanner is not available in this printer");
  }

}
void main(){
  HPPrinter hp=new HPPrinter();
  hp.displayPrinterinfo();
  hp.paperprint();
  hp.paperscan();
  print("\n");
  CanonPrinter cp=new CanonPrinter();
  cp.displayPrinterinfo();
  cp.paperprint();
  cp.paperscan();
}

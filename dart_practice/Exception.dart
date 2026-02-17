class toomanybondaException implements Exception {
  String toString() {
    return "Too many bonda";
  }
}

class InvalidbondaException implements Exception {
  String toString() {
    return "Invalid bonda amount";
  }
}

class Bondashop{

  int maxBonda=5 ;

  Bondashop(int quantity) {
    if (quantity <= 0) {
      throw InvalidbondaException();
    }
    if (quantity > maxBonda) {
      throw toomanybondaException();
    }
    
    print("Ordered $quantity bonda.");
  }
}

void main(){
  Bondashop shop = Bondashop(2);
  Bondashop shop2 = Bondashop(0);
  Bondashop shop3 = Bondashop(60);
}

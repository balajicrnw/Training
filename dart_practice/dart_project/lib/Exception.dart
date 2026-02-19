class toomanybondaException implements Exception {
  
}

class InvalidbondaException implements Exception {
  
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

  void orderBonda(int quantity) {
    try{
      Bondashop(quantity);
      
    }
  on InvalidbondaException catch(e){
      print("you didnt order any bonda");
  }
  on toomanybondaException catch(e){
      print("you ordered too many bondas");
  }
  catch(e){
      print("Error: $e");
  }
  finally{
    print("come to Bondashop daily");
  }
  }
}

void main(){
  Bondashop shop = Bondashop(3);
  shop.orderBonda(0);
  shop.orderBonda(6);
  shop.orderBonda(3);
}

class MenuModel {
  int id;
  String foodName;
  double price;
  MenuModel(this.id, this.foodName, this.price);
}

class Restaurent {
  List<MenuModel> menuList = [];

  Future<MenuModel> itemList(int id) async {
    List<MenuModel> itemsToAdd = [
      MenuModel(1, "Briyani", 250.0),
      MenuModel(2, "Chicken Fried Rice", 150.0),
      MenuModel(3, "Pasta", 100.0),
    ];

    for (var item in itemsToAdd) {
      await Future.delayed(Duration(seconds: 2)); 
      menuList.add(item);
      if (item.id == id) {
        return item;
      }
    }

    
    return MenuModel(0, "Invalid Item", 0.0);
  }

  Future<void> displayFood(int id) async {
    MenuModel item = await itemList(id);
    print("Food name: ${item.foodName}");
    print("Price: ${item.price}");
  }
}

Future<void> main() async {
  Restaurent r = Restaurent();
  await r.displayFood(1);

  await r.displayFood(3);
  await r.displayFood(2); 
}

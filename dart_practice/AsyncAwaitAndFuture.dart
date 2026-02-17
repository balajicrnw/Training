class MenuModel{
    int id;
    String foodName;
    double price;
    MenuModel(this.id, this.foodName, this.price);
}
class Restaurent{  
    List<MenuModel> menuList=[];
    Future<List<MenuModel>> menuService() async{
        
        await Future.delayed(Duration(seconds: 2));
        menuList.add(MenuModel(1, "Briyani", 250.0));
        await Future.delayed(Duration(seconds: 2));
        menuList.add(MenuModel(2, "Chicken Fried Rice", 150.0));
        await Future.delayed(Duration(seconds: 2));
        menuList.add(MenuModel(3, "Pasta", 100.0));
        return menuList;
    }
    
    Future<MenuModel> itemList(int id) async{
        await menuService();
        if(id==1){
            return menuList[0];
        }
        else if(id==2){
            return menuList[1];
        }
        else if(id==3){
            return menuList[2];
        }
        else{
            return(MenuModel(0,"Invalid Item", 0.0));
        }
    }

    Future<void> displayFood(int id) async{
        MenuModel item=await itemList(id);
        print("Food name: ${item.foodName} ");
        print("Price: ${item.price}");
    }   

}

Future<void> main() async{
    Restaurent r=new Restaurent();
    
    await r.displayFood(1);
    await r.displayFood(2);
    await r.displayFood(3);
    
}
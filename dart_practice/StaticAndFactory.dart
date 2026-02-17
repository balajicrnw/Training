void main(){
  Gamestore g1=new Gamestore("Balaji",21);
  Gamestore g2=new Gamestore("Vishal",17);
  Gamestore.displayNumberOfUsers();
  Gamestore g3=new Gamestore("Ganesh",22);
  Gamestore.displayNumberOfUsers();

}
class Gamestore{
  static int numberOfUsers=0;
  static final Gamestore defaultUser = Gamestore.newUser('Not available', 0);
  String userId;
  int age;
  Gamestore.newUser(this.userId,this.age);
  static void displayNumberOfUsers(){
    print("Total number of users: $numberOfUsers");
  }
  factory Gamestore(String userId, int age) {
    if(age>=18){
      numberOfUsers++;
      return Gamestore.newUser(userId, age);
      
    }
    
    print("Account creation denied to user: $userId. Age must be 18 or above.");
    return Gamestore.defaultUser; 
    
  }
}


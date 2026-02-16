class BankAccount{
  String? accountNumber;
  String? accountHolder;
  String? accountpin;
  double? _balance;

  BankAccount(this.accountNumber,this.accountHolder,this.accountpin,this._balance);
  void getBalance(String name,String pin){
    if(name==accountHolder && pin==accountpin){
    print("Current balance: $_balance");
  }
  else{
    print("Invalid credentials");
  }
  }

  void setBalance(double? newBalance){
    _balance=newBalance;
  }

  void deposit(double amount){
    _balance=(_balance??0)+amount;
    
  }
}

void main(){
  BankAccount b1=new BankAccount("123456789","Balaji","1234",500.0);
  b1.getBalance("Balaji","1234");
  b1.setBalance(1000.0);
  b1.getBalance("Balaji","1234");
  b1.deposit(500.0);
  b1.getBalance("Balaji","1234");

}
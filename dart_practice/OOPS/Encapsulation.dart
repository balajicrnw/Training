class BankAccount{
  double? _balance;

  void getBalance(){
    print("Current balance: $_balance");
  }

  void setBalance(double? newBalance){
    _balance=newBalance;
  }

  void deposit(double amount){
    _balance=(_balance??0)+amount;
    
  }
}

void main(){
  BankAccount b1=new BankAccount();
  b1.getBalance();
  b1.setBalance(1000.0);
  b1.getBalance();
  b1.deposit(500.0);
  b1.getBalance();

}
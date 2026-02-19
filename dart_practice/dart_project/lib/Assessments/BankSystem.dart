import 'dart:io';
class BankAccount{
  String? accountNumber;
  String? accountHolder;
  String? accountpin;
  double? _balance;

  BankAccount(this.accountNumber,this.accountHolder,this.accountpin,this._balance);
  double? getBalance(String number,String pin){
    return(_balance);
  }


  void deposit(double amount){
    _balance=(_balance??0)+amount;
    
  }

  void withdraw(double amount){
    if(amount>0){
      if(amount>_balance!){
        print("Insufficient balance");
      }
      else{
        _balance=_balance!-amount;
        print("Withdrawal successful. Current balance: $_balance");
      }
    }
    else{
      print("Enter valid amount");
    }
    
}
}

void main(){
  List<BankAccount> users=[];
  BankAccount user1=new BankAccount("123456789","Balaji","1234",500.0);
  while(true){
    print("Enter 1 to create new account");
    print("Enter 2 to deposit money");
    print("Enter 3 to withdraw money");
    print("Enter 4 to check balance");
    print("Enter 5 to exit");

    int input=int.parse(stdin.readLineSync()!);

    switch(input){
      case 1:
        print("Enter account number");
        String accountNumber=stdin.readLineSync()!;
        print("Enter account holder name");
        String accountHolder=stdin.readLineSync()!;
        print("Enter account pin");
        String accountpin=stdin.readLineSync()!;
        print("Enter initial balance");
        double balance=double.parse(stdin.readLineSync()!); 
        BankAccount user=new BankAccount(accountNumber,accountHolder,accountpin,balance);
        users.add(user);
        print("Account created successfully");
        break;
      case 2:
        print("Enter account number");
        String accountNumber=stdin.readLineSync()!;
        print("Enter amount to deposit");
        double amount=double.parse(stdin.readLineSync()!);
        for(BankAccount user in users!){
          if(user.accountNumber==accountNumber){
            user.deposit(amount);
            print("Amount deposited successfully");
            break;
          }
          else{
            print("Invalid account number");
          }
        }
        break;
      case 3:
        double? last_balance=0.0;
        print("Enter account number");
        String accountNumber=stdin.readLineSync()!;
        print("Enter account password");
        String accountpin=stdin.readLineSync()!;
        print("Enter amount to withdraw");
        double amount=double.parse(stdin.readLineSync()!);
        for(BankAccount user in users!){
          if(user.accountNumber==accountNumber && user.accountpin==accountpin){
            last_balance=user.getBalance(accountNumber , accountpin);
            user.withdraw(amount);
            print("Amount Withdrawn successfully");
            print("Last Balance: $last_balance");
            print("Current Balance: ${user.getBalance(accountNumber, accountpin)}");
            break;
          }
          else{
            print("Invalid account number");
          }
        }
        break;
      case 4:
        print("Enter account number");
        String accountNumber=stdin.readLineSync()!;
        print("Enter account password");
        String accountpin=stdin.readLineSync()!;
        for(BankAccount user in users!){
          if(user.accountNumber==accountNumber && user.accountpin==accountpin){
            print(user.getBalance(accountNumber, accountpin));
        }
        else{
          print("Invalid account number");
        }
      }
        break;
      case 5:
        exit(0);
      default:
        print("Invalid input");
    
    }
    }

}

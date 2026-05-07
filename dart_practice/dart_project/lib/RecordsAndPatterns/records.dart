
void main() {
  // we can create a tuple here (index-based fields)
  //we uae it to store values
  (String, int) user = ('Balaji', 21);

  //  access the values using index
  print(user.$1); 
  print(user.$2); 

  // here we can create a record with named fields (field-based fields)
  ({String name, int age}) employee = (
    name: 'Ganesh',
    age: 22,
  );

  print(employee.name);
  print(employee.age);

  ({
    String title,
    double price,
    bool inStock
  }) item = (
    title: 'Phone',
    price: 30000,
    inStock: true,
  );

  print(item.title);
  print(item.price);
  print(item.inStock);

  (int a,int b,int c) val1=(1,2,3);
  (int d,int e,int f) val2=(1,2,3);
  
  print(val1==val2);


  (String, int) person = ('Chukka', 222);

  // destructuring
  var (name, age) = person;

  print(name);
  print(age);


  // Named destructuring
  var employee2 = (
    name2: 'Aswin',
    salary2: 50000,
  );

  var (:name2, :salary2) = employee2;

  print(name2);
  print(salary2);

}
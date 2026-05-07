void main() {

  final user = getUser();
  print(user.name);
  print(user.age);

  final values = calculate(10, 20);
  print(values.sum);
  print(values.product);

  final student = getStudent();
  print(student.$1);
  print(student.$2);

  var (name1, marks) = getStudent();
  print(name1);
  print(marks);

  var (pincode:pin,city:city1) = getAddress();
  print(city1);
  print(pin);
}


// named record return type
({String name, int age}) getUser() {
  return (
    name: 'Balaji',
    age: 21,
  );
}

// returning multiple values using records
({int sum, int product}) calculate(int a, int b) {
  return (
    sum: a + b,
    product: a * b,
  );
}

// positional record return type
(String, int) getStudent() {
  return ('Ganesh', 95);
}

// named record return type
({String city, int pincode}) getAddress() {
  return (
    city: 'Avadi',
    pincode: 600071,
  );
}
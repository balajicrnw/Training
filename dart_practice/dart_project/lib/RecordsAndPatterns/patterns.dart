void main() {
  // we use it to unpack the values and pack values
  // map pattern
  var user = {
    'name': 'Ganesh',
    'age': 25,
  };

  if (user case {'name': String username, 'age': int userAge}) {
    print(username);
    print(userAge);
  }

  // switch pattern
  var response = ('success', 200);

  switch (response) {
    case ('success', 200):
      print('Success');

    case ('error', 404):
      print('Not Found');

    default:
      print('Unknown');
  }

  // object pattern
  var student = Student('Rahul', 90);

  if (student case Student(name: var studentName, marks: var marks)) {
    print(studentName);
    print(marks);
  }

  // wildcard pattern
  var (x, _, z) = (1, 2, 3);
  print(x);
  
  //print( _); is not possible bcz _ is not a variable
  // it is a wildcard pattern.
  
  print(z);

  // type checking pattern for dynamic variable
  dynamic value = 100;

  if (value case int number) {
    print(number);
  }
}

class Student {
  String name;
  int marks;

  Student(this.name, this.marks);
}
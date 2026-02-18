void ageValidation(int age){
  assert(age>=18, "Age must be at least 18");
  print("Age is valid: $age");
}
void main(){
  ageValidation( 21);
  ageValidation( 17);
} 
enum EnemyHealth{
  easy(100),
  medium(200),
  hard(300);

  final int health;
  const EnemyHealth(this.health);
}

void main(){
  EnemyHealth enemy=EnemyHealth.medium;
  print(enemy);
  print(enemy.health);
  print(EnemyHealth.hard.health);

}
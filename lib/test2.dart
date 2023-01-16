import 'dart:math';
void main () {
  var rand = Random();
  for (int i=0; i<10; i++) {
    print(rand.nextInt(3));
  }
}
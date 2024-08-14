import 'dart:math';

getRandom(){
  Random random = Random();
  int minHeight = 100;
  int maxHeight = 200;

  // Generate a random height between 100 and 200
  int randomHeight = minHeight + random.nextInt(maxHeight - minHeight + 1);
  return randomHeight.toDouble();
}
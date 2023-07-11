import 'dart:ui';

bool isColorSymilar(Color color1, Color color2, {int threshold = 50}) {
  int redDiff = (color1.red - color2.red).abs();
  int greenDiff = (color1.green - color2.green).abs();
  int blueDiff = (color1.blue - color2.blue).abs();
  return redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff <=
      threshold;
}

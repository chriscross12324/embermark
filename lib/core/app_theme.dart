
Color blendWithWhite(Color baseColour, double amount) {
  return Color.lerp(baseColour, Colors.white, amount.clamp(0.0, 1.0))!;
}
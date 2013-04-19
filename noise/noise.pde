float p = 0.0;

void setup() {
  size(320, 240);
}

void draw() {
  float noiseScale = 0.03;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < width; y++) {
      stroke(255 * noise(x * noiseScale + p, y * noiseScale + p));
      point(x,y);
    }
  }
  println(p);
  p = p + 0.01;
}



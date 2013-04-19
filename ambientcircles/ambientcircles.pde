int x_interval;
int y_interval;

void setup() {
  size(800, 600);
  //noStroke();
  background(10);
  frameRate(12);
  setIntervals();
}

void draw() {
  background(10);
  float grad = (1.0 * y_interval) / x_interval;
  for (int i = 0; i * x_interval <= width; i++) {
    for (int j = 0; j * y_interval <= height; j++) {
      int x = i * x_interval;
      int y = j * y_interval;
      noStroke();
      if (j % 2 == 0) {
        fill(50, 50 + random(150), 100 + random(155), 30);
        ellipse(x, y, 200, 200);
      }
      fill(155 + random(100), 50, 100 + random(55), 30);
      ellipse(x, y, 100, 100);
      stroke(255, 30);
      line(x, y, x + x_interval - 1, y);
      line(x, y, x, y + y_interval - 1);
      line(x, y, x + x_interval - 1, y + y_interval - 1);
      line(x, y, x - x_interval - 1, y + y_interval - 1);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    background(10);
    setIntervals();
  }
}

void setIntervals() {
  x_interval = width / (5 + int(random(10)));
  y_interval = height / 10;
}

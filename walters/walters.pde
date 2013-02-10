boolean drawWhite;
int s_height;
int last_x;
int x;
float prob_koru = .8; // Chance of a koru being drawn on each line
float prob_trip = .1; // Chance of each koru being a triple

void setup() {
  size(400, 600);
  background(0);
  noStroke();
  
  s_height = 15;
  noLoop();
}

void keyPressed() {
  redraw();
}


void draw() {
  last_x = x = 0;

  color light = color(50,100 + random(155), 100 + random(155));
  color dark = color(0,0,0);
  drawWhite = false;
  s_height = int(random(10) + 15);


  for (int i = 0; i <= height; i += s_height) {
    while (abs(last_x - x) < 4 * s_height) {
      x = int(random(width - 4 * s_height)) + s_height;
    }
    last_x = x;
    float k = random(1);

    if (drawWhite) {
      fill(light);
      drawWhite = false;
      rect(0, i, width, s_height);
      if (k < prob_koru && i >= 2 * s_height && i <= height - 2 * s_height) {
        drawKoru(x, i, s_height, light, dark);
      }
    }
    else {
      fill(dark);
      rect(0, i, width, s_height);
      if (k < prob_koru && i >= 3 * s_height && i <= height - 2 * s_height) {
        drawKoru(x, i, s_height, dark, light);
      }
      drawWhite = true;
    }
  }

  save("maheno.jpg");
}

void drawKoru(int x, int y, int h, color a, color b) {
  int e = h - 1;
  fill(b);
  if (random(1) < prob_trip) {
    rect(x, y, 4 * h, h);
    fill(a);
    ellipse(x, y + 1, 2 * e, 2 * e);
    ellipse(x + 2 * h, y + 1, 2 * e, 2 * e);
    ellipse(x + 4 * h, y + 1, 2 * e, 2 * e);
  }
  else {
    rect(x, y, 2 * h, h);
    fill(a);
    ellipse(x, y + 1, 2 * e, 2 * e);
    ellipse(x + 2 * h, y + 1, 2 * e, 2 * e);
  }
}

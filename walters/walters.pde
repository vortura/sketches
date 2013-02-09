boolean drawWhite;
int s_height;
int last_x;

void setup() {
  size(400, 400);
  background(0);
  noStroke();
  
  s_height = 20;
  drawWhite = false;
  last_x = 0;

  for (int i = 0; i <= height; i += s_height) {
    if (drawWhite) {
      fill(255);
      drawWhite = false;
    }
    else {
      fill(0);
      drawWhite = true;
    }
    rect(0, i, width, s_height);
  }

  drawWhite = true; 
  for (int i = 2 * s_height; i <= height - 2 * s_height; i += s_height) {

    int x = int(random(width));

    if (drawWhite) {
      if (last_x < width - 4 * s_height) { 
        println("black right");
        x = int(random(last_x + 4 * s_height, width - 4 * s_height));
      }
      else {
        println("black left");
        x = int(random(0 + s_height, last_x - 4 * s_height));
      }
      drawWhite = false;
    }
    else {
      if (last_x > 4 * s_height) { 
        println("white left");
        x = int(random(0 + s_height, last_x - 4 * s_height));
      }
      else {
        println("white right");
        x = int(random(last_x + 4 * s_height, width - 4 * s_height));
      }
      drawWhite = true;
    }
    last_x = x;
    drawKoru(x, i, s_height, drawWhite);
  }
  save("maheno.jpg");
}

void drawKoru(int x, int y, int h, boolean light) {
  int e = h - 1;
  if (light) {
    fill(0);
    rect(x, y, 2 * h, h);
    fill(255);
    ellipse(x, y + 1, 2 * e, 2 * e);
    ellipse(x + 2 * h, y + 1, 2 * e, 2 * e);
  }
  else {
    fill(255);
    rect(x, y, 2 * h, h);
    fill(0);
    ellipse(x, y + 1, 2 * e, 2 * e);
    ellipse(x + 2 * h, y + 1, 2 * e, 2 * e);
  }

}

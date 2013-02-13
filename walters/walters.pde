PGraphics big;
boolean drawLight;
int last_x;
int x;
int counter;
int MAXROW = 10;

float prob_koru = .8; // Chance of a koru being drawn on each line
float prob_trip = .1; // Chance of each koru being a triple

void setup() {
  big = createGraphics(4800, 7800, JAVA2D);
  big.beginDraw();
  big.smooth(8);
  size(big.width / 10, big.height / 10);
  background(0);
  big.noStroke();
  noLoop();
}

void keyPressed() {
  if (key == ' ') {
    redraw();
  }
  if (key == 's') {
    big.save("walters.tif");
  }
}


void draw() {
  last_x = x = 0;

  //color light = color(50,100 + random(155), 100 + random(155));
  color light = color(255,255,255);
  color dark = color(0,0,0);
  drawLight = false;
  int s_height = int(random(100) + 150);

  Row prev_row = new Row();

  for (int i = 0; i <= big.height; i += s_height) {
    while (abs(last_x - x) < 4 * s_height) {
      x = int(random(big.width - 4 * s_height)) + s_height;
    }
    last_x = x;
    
    color a = drawLight ? light : dark;
    color b = drawLight ? dark : light;

    big.fill(a);
    big.rect(0, i, big.width, s_height);
    
    float k = random(1);
    if (k < prob_koru && i >= 2 * s_height && i <= big.height - 2 * s_height) {
      drawKoru(x, i, s_height, a, b);
    }
    drawLight = !drawLight;
  }

  PImage img = big.get(0, 0, big.width, big.height);
  img.resize(width, height);
  image(img, 0, 0);
}

void drawKoru(int x, int y, int h, color a, color b) {
  int p = h / 20 + 1;
  int e = h - p;
  big.fill(b);
  if (random(1) < prob_trip) {      // Draw triple
    big.rect(x, y, 4 * h, h);
    big.fill(a);
    big.ellipse(x, y + p, 2 * e, 2 * e);
    big.ellipse(x + 2 * h, y + p, 2 * e, 2 * e);
    big.ellipse(x + 4 * h, y + p, 2 * e, 2 * e);
  }
  else {                            // else draw pair
    big.rect(x, y, 2 * h, h);
    big.fill(a);
    big.ellipse(x, y + p, 2 * e, 2 * e);
    big.ellipse(x + 2 * h, y + p, 2 * e, 2 * e);
  }
}

void close() {
  big.endDraw();
}

class Range {
  int lower;
  int upper;

  Range(int lower, int upper) {
    this.upper = upper;
    this.lower = lower;
  }

  int length() {
    return this.upper - this.lower;
  }
}
    
class Row {
  Range[] ranges;
  int index;

  Row() {
    index = 0;
    ranges = new Range[10];
    ranges[index++] = new Range(0, big.width);
  }

  boolean addKoru(int x, int length) {
    int i = this.findIndex(x);

    if (i != -1 && ranges[i].length() >= length) {
      if (ranges[i].lower == x) {
        ranges[i].lower = x + length + 1;
      }
      else {
        ranges[index].lower = x + length + 1;
        ranges[index].upper = ranges[i].upper;
        ranges[i].upper = x;
      }
      return true;
    }
    else {
      return false;
    }
  }

  int findIndex(int x) {
    for(int i = 0; i < 10; i++) {
      Range r = ranges[i];
      if (r.lower <= x && r.upper > x) {
        return i;
      }
    }
    return -1;
  }
}

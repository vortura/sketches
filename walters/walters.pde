import java.util.Arrays;

PGraphics big;
boolean drawLight;
int counter;
int MAXROW = 10;

float prob_koru = .9; // Chance of a koru being drawn on each line
float koru_probs[] = {.8, .1, .1 };
float prob_trip = .1; // Chance of each koru being a triple

void setup() {

  big = createGraphics(4800, 7800, JAVA2D);
  big.beginDraw();
  //big.smooth(8);
  big.noStroke();

  size(big.width / 10, big.height / 10);
  background(0);
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
  //color light = color(50,100 + random(155), 100 + random(155));
  color light = color(255,255,255);
  color dark = color(0,0,0);
  int row_height = int(random(100) + 150);
  drawLight = false;
  Row prev_row = new Row();

  for (int i = 0; i <= big.height; i += row_height) {
    Row row = new Row();

    color a = drawLight ? light : dark;
    color b = drawLight ? dark : light;

    big.fill(a);
    big.rect(0, i, big.width, row_height);
    
    if (i <= 2 * row_height || i >= big.height - 2 * row_height) {
      drawLight = !drawLight;
      prev_row = row;
      continue;
    }
  
    for (float p : koru_probs) {
      float k = random(1);
      if (k < p) {
        float t = random(1);
        
        if (t < prob_trip) {
          int x = prev_row.findSpace(6 * row_height);
          if (x >= 0) {
            drawTriple(x, i, row_height, a, b);
            row.addKoru(x, 6 * row_height);
            prev_row.addKoru(x, 6 * row_height);
          }
        }
        else {
          int x = prev_row.findSpace(4 * row_height);
          if (x >= 0) {
            drawKoru(x, i, row_height, a, b);
            row.addKoru(x, 4 * row_height);
            prev_row.addKoru(x, 4 * row_height);
          }
        }
      }
      else {
        break;
      }
    }

    drawLight = !drawLight;
    prev_row = row;
  }

  PImage img = big.get(0, 0, big.width, big.height);
  img.resize(width, height);
  image(img, 0, 0);
}

void drawKoru(int x, int y, int h, color a, color b) {
  int p = h / 20 + 5;    // Control size of gaps between korus.
  int e = h - p;
  big.fill(b);
  big.rect(x + e, y, 2 * h, h);
  big.fill(a);
  big.ellipse(x + e, y + p, 2 * e, 2 * e);
  big.ellipse(x + e + 2 * h, y + p, 2 * e, 2 * e);
}

void drawTriple(int x, int y, int h, color a, color b) {
  int p = h / 20 + 5;    // Control size of gaps between korus.
  int e = h - p;
  big.fill(b);
  big.rect(x + e, y, 4 * h, h);
  big.fill(a);
  big.ellipse(x + e, y + p, 2 * e, 2 * e);
  big.ellipse(x + e+ 2 * h, y + p, 2 * e, 2 * e);
  big.ellipse(x + e + 4 * h, y + p, 2 * e, 2 * e);
}

void close() {
  big.endDraw();
}

class Range implements Comparable {
  int lower;
  int upper;

  Range(int lower, int upper) {
    this.upper = upper;
    this.lower = lower;
  }

  int length() {
    return upper - lower;
  }

  int compareTo(Object o){
    Range r = (Range)o;
    return this.lower - r.upper;
  }
}
    
class Row {
  Range[] ranges;
  int next_index;

  Row() {
    next_index = 0;
    ranges = new Range[10];
    ranges[next_index++] = new Range(0, big.width);
  }

  boolean addKoru(int x, int length) {
    int i = this.findIndex(x);

    if (i != -1 && ranges[i].upper >= x + length) {
      if (ranges[i].lower == x) {
        ranges[i].lower = x + length + 1;
      }
      else {
        ranges[next_index++] = new Range(x + length + 1, ranges[i].upper);
        ranges[i].upper = x;
      }
      return true;
    }
    else {
      return false;
    }
  }

  int findIndex(int x) {
    for(int i = 0; i < next_index ; i++) {
      Range r = ranges[i];
      if (r.lower <= x && r.upper > x) {
        return i;
      }
    }
    return -1;
  }

  int findSpace(int len) {
    int total_usable = 0;
    for(int i = 0; i < next_index ; i++) {
      int usable_len = ranges[i].length() - len;
      if (usable_len > 0) {
        total_usable += usable_len;
      }
    }
    int tmp = 0;
    if (total_usable != 0) {
      int k = int(random(total_usable));

      for(int i = 0; i < next_index ; i++) {
        int usable_len = ranges[i].length() - len;
        if (usable_len > 0) {
          if (k - usable_len < 0) {
            return ranges[i].lower + k;
          }
          else {
            k = k - usable_len;
          }
        }
      }
    }
    return -1;
  }

  void print() {
    for(int i = 0; i < next_index ; i++) {
      println(ranges[i].lower + "-" + ranges[i].upper + " (" + ranges[i].length() + "),");
    }

  }
}

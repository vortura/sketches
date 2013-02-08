int w = 1024;
int h = 768;

int R = 100;  // Radius of static circle
int r = 60;  // Radius of rolling circle
int d = 100;   // distance from centre of rolling circle to draw point

float x, y, i, k, last = 0.0;

void setup() {
  size(w, h);
  frameRate(25);
  background(245);
  strokeWeight(2);
  stroke(15,5,10);
  noFill();
  smooth();
}

void draw() {
  
  background(245);
  
  // Draw static circle
  ellipse(w/2, h/2, 2 * R, 2 * R);
  
  // Calc centre of rolling circle;
  x = w/2 + cos(i) * (R - r);
  y = h/2 + sin(i) * -1 * (R - r);
  
  float arclen = (i - last) * R;
  float rot = arclen / r;
  
  // Draw rolling circle with line 
  ellipse(x, y, 2 * r, 2 * r);
  line(x, y, x + cos(i + k) * d, y + sin(i + k) * d);
  //point(x + cos(i + k) * d, y + sin(i + k) * d);
  last = i;
  i = i + PI / 90;
  k = k + rot;
}

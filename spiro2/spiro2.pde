int w = 700;
int h = 700;

Trochoid troc;
float i = 0.0;
float incr = 0.05;
float R = 0.0;

void setup() {
  size(w, h, P2D);
  smooth(8);
  strokeWeight(2);
  troc = new Trochoid();
}

void draw() {

  R += incr;
  if(R > width/2)
    R = 0.0;

  if(keyPressed) {
    if(key==' ')
      save("spiro.jpg");
  }
  
  background(0);
  troc.init(R, mouseX / 2, mouseY / 2);
  troc.draw();
}

class Trochoid {
  float R; // Radius of fixed circle
  float r; // Radius of moving circle that traces the fixed circle
  float d; // Distance from centre of moving circle to draw point
  boolean first = true;
  float x, last_x;
  float y, last_y;
  float t; 

  Trochoid() {
  }

  void init(float R, float r, float d) {
    this.R = R;
    this.r = r;
    this.d = d;
    this.t = 0.0;
    first = true;
  }

  void draw() {

    for (int i = 0; i < 1000; i++) {
      stroke(sin(PI * i/1000) * 255);

      float k = (R - r) / r;

      float x = width / 2 + ((R - r) * cos(t)) + d * cos(k * t);
      float y = height / 2 - ((R - r) * sin(t)) + d * sin(k * t);

      if (first) {
        first = false;
      }
      else {
        line(last_x, last_y, x, y);
        //point(x, y);
      }

      last_x = x;
      last_y = y;
      
      t = t + incr;
    }

  }
}

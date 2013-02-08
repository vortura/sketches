int count = 3;
Beam[] beams = new Beam[count];
Beam b1;

void setup() {
  size(512, 512);
  smooth();
  frameRate(16);
  for (int i = 0;i < count;i++) {
    beams[i] = new Beam(random(2 * PI), PI / 16);
  }
  
}

void draw() {
  background(15);
  for (int i = 0;i < count;i++) {
    beams[i].display();
    beams[i].move();
  }
  
}

class Beam {
  float position;  // Centre of beam (in radians)
  float width; // beam width in radians
  
  Beam(float p, float w) {
    this.position = p;
    this.width = w;
  }
  
  void move() {
      this.position = random(2 * PI);
      this.width = random(PI / 16) + PI / 32;
  }
  
  void display() {
    arc(256, 256, 750, 750, position - width / 2, position + width / 2);
  }
}

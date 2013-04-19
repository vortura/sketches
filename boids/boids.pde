int count = 350;
Boid[] boids = new Boid[count];

float maxforce = 0.04;
float maxspeed = 2;
float r = 4.0;

float align_radius = 100.0;
float cohesion_radius = 100.0;
float separation_radius = 30.0;

void setup() {
  size(1280, 720);
  smooth();
  noStroke();

  for (int i = 0; i < count; i++) {
    boids[i] = new Boid(width/2,height/2);
  }
}

void draw() {
  background(60);
  for (int i = 0; i < count; i++) {
    boids[i].run();
  }
}

class Boid {

  PVector location;
  PVector velocity;
  PVector accel;
  color col;
  float dist = 0;

  Boid(float x, float y) {
    this.location = new PVector(x, y);
    this.velocity = new PVector(random(-1,1),random(-1,1));
    this.accel = new PVector(0,0);
    this.col = color(50, 100 + random(155.0), 155 + random(100));
  }
  
  void run() {
    calcForces();
    update();
    borders();
    this.draw();
  }

  void draw() {
    fill(col);
    float h = velocity.heading();
    pushMatrix();
    translate(location.x, location.y);
    rotate(h - PI / 4.0);
    rect(0, 0, r, r);
    ellipse(0, 0, 2 * r, 2 * r);
    popMatrix();
  }

  PVector separate() {
    PVector s = new PVector(0,0,0);
    int count = 0;
    for (Boid b : boids) {
      float d = PVector.dist(this.location, b.location);
      if (d > 0 && d < separation_radius) {
        PVector p = PVector.sub(this.location, b.location);
        p.normalize();
        p.div(d + r);
        s.add(p);
        count++;
      }
    }
    if (count > 0) {
      s.div((float)count);
    }
    if (s.mag() > 0) {
      s.normalize();
      s.mult(maxspeed);
      s.sub(velocity);
      s.limit(maxforce);
    }
    return s;
  }

  PVector align() {
    PVector s = new PVector(0, 0);
    int count = 0;
    for (Boid b : boids) {
      float d = PVector.dist(this.location, b.location);
      if (d > 0 && d < align_radius) {
        s.add(b.velocity);
        count++;
      }
    }
    if (count > 0) {
      s.div((float)count);
      s.normalize();
      s.mult(maxspeed);
      s.sub(velocity);
      s.limit(maxforce);
    }
    return s;
  }

  PVector cohesion() {
    PVector s = new PVector();
    PVector p = new PVector();
    int count = 0;
    for (Boid b : boids) {
      float d = PVector.dist(this.location, b.location);
      if (d > 0 && d < cohesion_radius) {
        s.add(b.location);
        count++;
      }
    }
    if (count > 0) {
      s.div(count);
      this.dist = PVector.dist(this.location, s);
      p = PVector.sub(s, this.location);
      p.normalize();
      p.mult(maxspeed);
      p.sub(velocity);
      p.limit(maxforce);
    }
    else {
      dist = 0;
    }
    return p;
  }

  void borders() {
    float p = 2 * r;
    if (location.x < -p) location.x = width+p;
    if (location.y < -p) location.y = height+p;
    if (location.x > width+p) location.x = -p;
    if (location.y > height+p) location.y = -p;
  }

  void calcForces() {
    PVector sep = separate();
    PVector coh = cohesion();
    PVector aln = align();
    sep.mult(2.5);
    coh.mult(1.0);
    aln.mult(1.0);

    accel.add(sep);
    accel.add(aln);
    accel.add(coh);
  }

  void update() {
    velocity.add(accel);
    velocity.limit(maxspeed);

    location.add(velocity);
    borders();
    accel.mult(0);
  }
}

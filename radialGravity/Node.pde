class Node {

  PVector pos;
  PVector vel;
  float radius;
  float mass;
  float growthRate;
  float currentAlpha;
  color clr;
  String name;
  boolean hit;
  boolean killMe;
  int vertexCount;
  ArrayList hitVectors;


  Node (PVector _pos, float _radius ) {
    pos = _pos;
    radius = _radius;
    mass = _radius/750;
    clr = color(random(40, 60), 100, 100);
    growthRate = 1;
    hit = false;
    killMe = false;
    currentAlpha = 50;
    vertexCount = 48;
    hitVectors = new ArrayList();
  }

  void display() {

    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(clr, currentAlpha/3);
    ellipse(0, 0, radius*2, radius*2); 

    drawEdge();

    popMatrix();
  }

  void update() {

    pos.div(1+mass);
  } 

  boolean hitTest(PVector m) {
    if (m.dist(pos) < radius) {
      return true;
    } 
    else {
      return false;
    }
  }

  void drawEdge() {
    fill(100, 50);
    noStroke();
    beginShape();
    for (int i=0; i<vertexCount; i++) {
      float rad = TWO_PI/vertexCount * i;
      PVector v = new PVector(cos(rad)*radius, sin(rad)*radius);
      if (hitVectors.size()>0) {
        for (int j=0; j<hitVectors.size(); j++) {
          PVector p = (PVector) hitVectors.get(j);
          PVector c = v.get();
          c.normalize();
          p.normalize();
          float a = PVector.angleBetween(c, p);
          println(i +":"+a);
          //p.add(c);
          if (abs(a) < .3) {
             println("mag is small:" + a);
             c.mult(radius/10);
             v.add(c);
          }
        }
      }
      //ellipse(v.x, v.y, 2, 2);
      vertex(v.x , v.y);
    }
    endShape(CLOSE);
  }

  void clearVectors() {
    for (int i=0; i<hitVectors.size(); i++) {
      hitVectors.remove(i);
    }
  }
};



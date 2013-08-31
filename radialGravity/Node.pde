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
  boolean resizeMe;
  int vertexCount;
  ArrayList hitVectors;


  Node (PVector _pos, float _radius ) {
    pos = _pos;
    radius = _radius;
    mass = _radius*_radius/100000;
    //clr = color(random(40, 60), 100, 100);
    clr = color(.1, 1, 1);
    growthRate = 1;
    hit = false;
    killMe = false;
    currentAlpha = 50;
    vertexCount = 20;
    hitVectors = new ArrayList();
  }

  void display() {

    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(clr, currentAlpha);
    ellipse(0, 0, radius*2, radius*2); 

    //drawEdge();

    popMatrix();
  }

  void update() {
    pos.div(1+mass);
    
  } 
  
  void toggleResize() {
    resizeMe = !resizeMe;
    if (resizeMe) {
      clr = color(.5, 1, 1);
    } else {
      clr = color(.1, 1, 1);
    }
      
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
    //beginShape();
    for (int i=0; i<vertexCount; i++) {
      float rad = TWO_PI/vertexCount * i;
      PVector v = new PVector(cos(rad), sin(rad));
      float dampen = 1.0;
      if (hitVectors.size()>0) {
        for (int j=0; j<hitVectors.size(); j++) {
          PVector p = (PVector) hitVectors.get(j);
          PVector c = v.get();
          
          float dist = c.dist(p);
          println(i +":"+dist);
          if (dist < 50) dampen = dist/200;
     
        }
      }
      
      ellipse(v.x * radius * dampen, v.y * radius * dampen, 3, 3);
      stroke(100, 20);
      line(0, 0, v.x, v.y);
      //vertex(v.x * dampen , v.y * dampen);
    }
    //endShape(CLOSE);
  }

  void clearVectors() {
    for (int i=0; i<hitVectors.size(); i++) {
      hitVectors.remove(i);
    }
  }
};



class Node {

  PVector pos;
  PVector vel;
  float radius;
  float mass;
  float growthRate;
  float currentAlpha;
  color clr;
  color clr2 = color(random(0, 1), 1, .5);
  String name;
  boolean hit;
  boolean killMe;
  boolean resizeMe;
  int vertexCount;
  ArrayList hitVectors;
  ArrayList sortedVectors;


  Node (PVector _pos, float _radius ) {
    pos = _pos;
    radius = _radius;
    mass = _radius*_radius/120000;
    if (mass < .05) mass = .02;
    println(mass);
    clr = color(1, 0, 1);
    growthRate = 1;
    hit = false;
    killMe = false;
    currentAlpha = .8;
    vertexCount = 20;
    hitVectors = new ArrayList();
    sortedVectors = new ArrayList();
  }

  void display() {

    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(clr, 1);
    ellipse(0, 0, radius*1.75, radius*1.75); 
    ellipse(0, 0, radius*1.8, radius*1.8); 
    fill(clr, currentAlpha);
    ellipse(0, 0, radius*2, radius*2); 

    sortVectors();
    //drawEdge();

    popMatrix();
  }

  void update() {
    pos.div(1+(mass));
  } 

  void toggleResize() {
    resizeMe = !resizeMe;
    if (resizeMe) {
      clr = color(.5, 1, 1);
    } 
    else {
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

  void sortVectors() {

    float lowIndex = 0;

    float[] angles = new float[hitVectors.size()];

    for (int i=0; i<hitVectors.size(); i++) {
      PVector v = (PVector) hitVectors.get(i);
      angles[i] = v.z;
    }

    angles = sort(angles);

    for (int i=angles.length-1; i>0; i--) {

      for (int j=0; j<hitVectors.size(); j++) {
        PVector v = (PVector) hitVectors.get(j);
        if (v.z == angles[i]) {
          sortedVectors.add(v);
          j = hitVectors.size();
        }
      }
    }
  }

  void drawEdge() {
    fill(clr, 1);
    stroke(1, 1);
    //fill(clr2);
    //noStroke();
    //noFill();
    noStroke();

    beginShape();
    for (int i=0; i<sortedVectors.size(); i++) {
      PVector v = (PVector) sortedVectors.get(i);
      //ellipse(v.x, v.y, 10, 10);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }

  void clearVectors() {

    while (hitVectors.size () > 0) hitVectors.remove(0);
    while (sortedVectors.size () > 0) sortedVectors.remove(0);
  }
};


class Node {

  PVector pos;
  PVector vel;
  float radius, radiusTarg;
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
  ArrayList neighbors;
  ArrayList sortedNeighbors;


  Node (PVector _pos, float _radius ) {
    pos = _pos;
    radiusTarg = _radius;
    radius = 0;
    mass = _radius*_radius/240000;
    if (mass < .05) mass = .02;
    //println(mass);
    clr = color(.6, 1, 1);
    growthRate = 1;
    hit = false;
    killMe = false;
    currentAlpha = .8;
    vertexCount = 20;
    neighbors = new ArrayList();
    sortedNeighbors = new ArrayList();
  }

  void display() {

    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(clr, 1);
    //ellipse(0, 0, radius*1.75, radius*1.75); 
    //ellipse(0, 0, radius*1.8, radius*1.8); 
    fill(clr, currentAlpha);
    ellipse(0, 0, radius*2, radius*2); 

    //drawEdge();

    popMatrix();
  }

  void update() {
    pos.div(1+(mass));
    radius += (radiusTarg - radius) * .3;
    sortNeighbors();
  } 

  void toggleResize() {
    resizeMe = !resizeMe;
    if (resizeMe) {
      clr = color(.58, 1, 1);
    } 
    else {
      clr = color(.6, 1, 1);
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

  void sortNeighbors() {
    float lowIndex = 0;
    float[] angles = new float[neighbors.size()];

    for (int i=0; i<neighbors.size(); i++) {
      PVector v = (PVector) neighbors.get(i);
      angles[i] = v.z;
    }

    angles = sort(angles);

    for (int i=angles.length-1; i>0; i--) {
      for (int j=0; j<neighbors.size(); j++) {
        PVector v = (PVector) neighbors.get(j);
        if (v.z == angles[i]) {
          sortedNeighbors.add(v);
          j = neighbors.size();
        }
      }
    }
  }

  void drawEdge() {
    fill(clr, 1, 0.5);
    stroke(clr, 1, 0.5);
    //noStroke();

    beginShape();
    for (int i=0; i<sortedNeighbors.size(); i++) {
      PVector v = (PVector) sortedNeighbors.get(i);
      int k = (i+1)%sortedNeighbors.size();
      PVector next = (PVector) sortedNeighbors.get(k);
      //ellipse(v.x, v.y, 10, 10);
      vertex(v.x, v.y);
      //bezierVertex(v.x, v.y, next.x, next.y, next.x, next.y);
    }
    endShape(CLOSE);
  }

  void clearVectors() {
    while (neighbors.size () > 0) neighbors.remove(0);
    while (sortedNeighbors.size () > 0) sortedNeighbors.remove(0);
  }
};
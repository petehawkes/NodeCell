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
    mass = _radius*_radius/100000;
    if (mass < .05) mass = .02;
    println(mass);
    clr = color(.1, 1, 1);
    growthRate = 1;
    hit = false;
    killMe = false;
    currentAlpha = .5;
    vertexCount = 20;
    hitVectors = new ArrayList();
  }

  void display() {

    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(clr, currentAlpha);
    ellipse(0, 0, radius*2, radius*2); 

    sortVectors();
    drawEdge();

    popMatrix();
  }

  void update() {
    pos.div(1+(mass)); 
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
  
  void sortVectors() {
     
  }

  void drawEdge() {
    fill(clr, 1);
    //fill(clr2);
    noStroke();
    //beginShape();
    for (int i=0; i<hitVectors.size(); i++) {
      PVector v = (PVector) hitVectors.get(i);
      ellipse(v.x, v.y, 10, 10);
      //vertex(v.x, v.y);
    }
    //endShape(CLOSE);
  }

  void clearVectors() {
    println("size:"+hitVectors.size());
//    for (int i=hitVectors.size()-1; i>0; i--) {
//      hitVectors.remove(i);
//    }
    while(hitVectors.size() > 0) hitVectors.remove(0);
    println("sizeafter:"+hitVectors.size());
  }
};



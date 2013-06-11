class Node {
  
  PVector pos;
  PVector vel;
  float rad;
  float mass;
  float growthRate;
  float currentAlpha;
  color clr;
  String name;
  boolean hit;
  boolean killMe;
  

  Node (PVector _pos, float _rad ) {
    pos = _pos;
    rad = _rad;
    mass = _rad/750;
    clr = color(random(40, 60), 100, 100);
    growthRate = 1;
    hit = false;
    killMe = false;
    currentAlpha = 50;
  }
  
  void display() {
    
     pushMatrix();
     translate(pos.x, pos.y);
     noStroke();
     fill(clr, currentAlpha);
     ellipse(0, 0, rad*2, rad*2); 
     popMatrix();
    
  }
  
  void update() {
    
    pos.div(1+mass);
    
  } 
  
  boolean hitTest(PVector m) {
    if (m.dist(pos) < rad) {
      return true;
    } else {
      return false;
    }
  }
  
 
  
};
  
  



ArrayList allNodes;


void setup() {

  size(800, 600);
  smooth();
  noStroke();

  colorMode(HSB, 100);

  allNodes = new ArrayList();

  for (int i=0; i<40; i++) {
    PVector p = new PVector(random(-10, 10), random(-10, 10)); 
    addNode(p, random(5, 60));
  }
}




void draw() {

  background(0);


  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i<allNodes.size(); i++) {
    Node c = (Node) allNodes.get(i);
    checkHit(c);
    c.update();
    c.display();
  }
  popMatrix();
  
  killDeadNodes();
}


void checkHit(Node n) {


  for (int i=0; i<allNodes.size(); i++) {
    Node c = (Node) allNodes.get(i);
    
    if (c != n) {
      float d = c.pos.dist(n.pos);
      float x = c.pos.x - n.pos.x;
      float y = c.pos.y - n.pos.y;
      float r = c.rad + n.rad;
      if (d < r) {      
          d = (d - r) / d * .5;
          c.pos.x -= x *= d;
          c.pos.y -= y *= d;
          n.pos.x += x;
          n.pos.y += y;   
      }
    }
  }

 
}



void addNode(PVector newPos, float rad) {
  allNodes.add(new Node(newPos, rad));
}


void checkNode() {
 
    boolean gotHit = false;
    float mx = mouseX - width/2;
    float my = mouseY - height/2;
  
    for (int i=0; i<allNodes.size(); i++) {
    Node c = (Node) allNodes.get(i);
      if (c.hitTest(new PVector(mx, my))) {
         c.killMe = true;
         gotHit= true;
      } 
    }
    
    if (!gotHit) addNode(new PVector (mx, my), random(10, 60));

  
}



void killDeadNodes() {
 for (int i=allNodes.size()-1; i>=0; i--) {
    Node c = (Node) allNodes.get(i);
    if (c.killMe) allNodes.remove(i);
  } 
}






void mousePressed() {
  checkNode();
}

void mouseReleased() {
  //drawing = true;
}




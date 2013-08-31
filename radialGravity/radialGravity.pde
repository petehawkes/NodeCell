

ArrayList allNodes;
int minSize = 20;
int maxSize = 100;


void setup() {

  size(800, 600);
  smooth();
  noStroke();

  colorMode(HSB, 1.0);

  allNodes = new ArrayList();

  for (int i=0; i<2; i++) {
    PVector p = new PVector(random(-10, 10), random(-10, 10)); 
    addNode(p, random(minSize, maxSize));
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

  n.clearVectors();

  for (int i=0; i<allNodes.size(); i++) {
    Node c = (Node) allNodes.get(i);

    if (c != n) {
      float d = c.pos.dist(n.pos);
      float x = c.pos.x - n.pos.x;
      float y = c.pos.y - n.pos.y;
      float r = c.radius + n.radius;
      if (d < r) {
        d = (d - r) / d * .5;
        c.pos.x -= x *= d;
        c.pos.y -= y *= d;
        n.pos.x += x;
        n.pos.y += y;      
        n.hitVectors.add(new PVector(c.pos.x-n.pos.x, c.pos.y - n.pos.y));
        //println(n.hitVectors);
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
      //c.killMe = true;
      c.toggleResize();
      gotHit= true;
    }
  }

  if (!gotHit) { 
    addNode(new PVector (mx, my), random(minSize, maxSize));
  }
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

void keyPressed() {
  
 
     for (int i=allNodes.size()-1; i>=0; i--) {
        Node c = (Node) allNodes.get(i);
        if (c.resizeMe) {
          if (key == 'x') c.radius *= 1.2;
          if (key == 'z') c.radius *= .8;
        }  
      }
  

}



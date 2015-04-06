

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


void checkHit(Node self) {
  self.clearVectors();
  
  println(self.vertexCount);

  for (int i=0; i<allNodes.size(); i++) {
    Node neighbor = (Node) allNodes.get(i);

    if (self != neighbor) {
      float distance = neighbor.pos.dist(self.pos);
      float x = neighbor.pos.x - self.pos.x;
      float y = neighbor.pos.y - self.pos.y;
      float touchDistance = neighbor.radius + self.radius;

      // check to see if I'm touching my neighbor
      if (distance < touchDistance) {
          float overlap = (distance - touchDistance) / distance;
          overlap *= .5; // each only moves half, since the neighbor moves too
          neighbor.pos.x -= x * overlap;
          neighbor.pos.y -= y * overlap;
          self.pos.x += x * overlap;
          self.pos.y += y * overlap; 
      }
      if (distance < touchDistance * 1.2) {
          //
          // store close neighbors for edge drawing
          PVector v = new PVector(neighbor.pos.x, neighbor.pos.y);  
          v.sub(self.pos);
          v.normalize();
          v.mult(self.radius);
          v.z = v.heading();
          self.neighbors.add(v);
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
    for (int i=0; i<1; i++)
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
          if (key == 'x') c.radiusTarg *= 1.2;
          if (key == 'z') c.radiusTarg *= .8;
        }  
      }
  

}



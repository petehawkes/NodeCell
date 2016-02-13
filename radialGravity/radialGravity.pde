

ArrayList allNodes;
int minSize = 20;
int maxSize = 100;

float system_right = 0;
float system_left = 0;
float system_top = 0;
float system_bottom = 0;


void setup() {

  size(800, 800);
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

  background(1);

  pushMatrix();
  translate(width/2, height/2);

  system_right = 0;
  system_left = 0;
  system_top = 0;
  system_bottom = 0;

  for (int i=0; i<allNodes.size(); i++) {
    Node c = (Node) allNodes.get(i);
    checkHit(c);
    c.update();
    c.display();
    checkBounds(c);
  }
  
  fill(.2, 1, 1);
  ellipse(system_right, 0, 10, 10);
  fill(.4, 1, 1);
  ellipse(system_left, 0, 10, 10);
  fill(.6, 1, 1);
  ellipse(0, system_top, 10, 10);
  fill(.8, 1, 1);
  ellipse(0, system_bottom, 10, 10);
 
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  
  noFill();
  stroke(1, 0, 0.7);
  ellipse(0, 0, 600, 600);
  popMatrix();


  killDeadNodes();
}

void checkBounds (Node c) {
  if (c.pos.x > system_right) system_right = c.pos.x + c.radius;
  if (c.pos.x < system_left) system_left = c.pos.x - c.radius;
  if (c.pos.y > system_top) system_top = c.pos.y + c.radius;
  if (c.pos.y < system_bottom) system_bottom = c.pos.y - c.radius;
}

void checkHit(Node self) {
  self.clearVectors();

  //println(self.vertexCount);

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
        //v.z = v.heading();
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
    if (c.hitTest(new PVector((mouseX - width/2), (mouseY - height/2)))) {
      if (key == 'x') c.radiusTarg *= 1.1; 
      if (key == 'z') c.radiusTarg *= .9;
    }
  }
}


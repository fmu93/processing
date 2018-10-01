FlowField flowField;
Body body;

void setup() {
 size(1000, 800);
 background(0);
 
 flowField = new FlowField();
 body = new Body();
 
}

void draw() {
  
  background(0);
  body.run(flowField.lookup(body.pos));
  flowField.timeStep();
  
}

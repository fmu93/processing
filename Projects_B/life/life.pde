// Game Of Life

GOL gol;

void setup() {
  size(800, 800);
  frameRate(30);
  background(0);
  gol = new GOL();
  
}

void draw() {
  gol.display();
  gol.generate();
}

void mouseClicked() {
 gol.reset(); 
}

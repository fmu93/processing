class FlowField {
  PVector[][] field;
  int resolution = 50;
  int cols = width/resolution + 1;
  int rows = height/resolution + 1;

  float toff = 0;
  float deltaTime = 0.002;
  float deltaOff = 0.2;
  
  FlowField() {
    field = new PVector[cols][rows];
    init();
  }

  void init() {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        field[i][j] = PVector.fromAngle(map(noise(xoff, yoff, toff), 0, 1, 0, TWO_PI));

        yoff += deltaOff;
      }
      xoff += deltaOff;
    }
  }

  void timeStep() {
    toff += deltaTime;
    init();
  }

  PVector lookup(PVector lookup) {
    int col = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[col][row];
  }

  void display() {
    stroke(200);
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        pushMatrix();
        strokeWeight(field[i][j].mag());
        translate(resolution*i, resolution*j);
        rotate(field[i][j].heading());
        ellipse(0, 0, 4, 4);
        line(0, 0, 30, 0);
        popMatrix();
      }
    }
  }
}

LSystem lsys;
Turtle turtle;

void setup() {
  size(1000, 1000);
  background(255);
  strokeWeight(1);
  stroke(0);

  Rule[] ruleset = new Rule[2];

  // cool leaves
  //ruleset[0] = new Rule('F', "F[-F-[F+GF]-F]F[-GF][++F-[FF]-[+++GF]]");
  //lsys =  new LSystem("F[-F][+F]", ruleset);

  //// fractal plant from wikipedia
  ruleset[0] = new Rule('X', "F+[[X]-X]-F[-FX]+X");
  ruleset[1] = new Rule('F', "FF");
  lsys =  new LSystem("X", ruleset);

  //// fractal plant from wikipedia
  //ruleset[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");
  //lsys =  new LSystem("F", ruleset);

  turtle = new Turtle(lsys.getSentence(), 200, radians(25)); 

  smooth();
}

void draw() {
  background(255);
  fill(0);

  translate(width/2, height*0.8);
  rotate(-PI/2);
  turtle.render();
  noLoop();
}

int counter = 0;

void mousePressed() {
  if (counter < 10) {
    pushMatrix();
    lsys.generate();
    //println(lsys.getSentence());
    turtle.setToDo(lsys.getSentence());
    turtle.changeLen(0.5);
    popMatrix();
    redraw();
    counter++;
    stroke(0, 200/(counter+1));
  }
}

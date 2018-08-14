class Ship extends Body {
  
  Ship(float x0, float y0) {
   super(x0, y0); 
  }
  
  void display() {
    lookAhead();
    stroke(0, 50);
    fill(0, 0, 255, 80);
    //ellipse(loc.x, loc.y, size, size);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(angle);
    arrow();
    //star(0, 0, size, size/3, 3);
    //rectMode(CENTER);
    //rect(0, 0, size*2, size/2);
    popMatrix();
  }
  
  void lookAhead() {
    angle = vel.heading();
  }
  
  void arrow() {
   beginShape();
   vertex(size, 0);
   vertex(-size, -size/2);
   vertex(-size, size/2);
   endShape(CLOSE);
  }
  
  void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
}

class PolarBody {
 float r;
 float theta;
 float rdot;
 float thetadot;
 float rdotdot;
 float thetadotdot;
 
 float size = 20;
 float mass = 1;
 
 PolarBody(float r_, float theta_, float rdot_, float thetadot_) {
   r = r_;
   theta = theta_;
   rdot = rdot_;
   thetadot = thetadot_;
   rdotdot = 0;
   thetadotdot = 0;
 }
 
 void applyPolarForce(float rForce, float thetaForce) {
  rdotdot += rForce/mass;// + r*thetadot*thetadot;
  thetadotdot += 0;
 }
 
 void update() {
   rdot += rdotdot;
   r += rdot;
   rdotdot = 0;
   
   thetadot += thetadotdot;
   theta += thetadot;
   thetadotdot = 0;
  }
 
 void display() {
    stroke(0);
    fill(255);
    float x = r*cos(theta);
    float y = -r*sin(theta);
    ellipse(x, y, size, size); 
 }
  
  
  
}

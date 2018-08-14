PVector polar2card (float r, float angle) {
  float x = r*cos(angle);
  float y = -r*sin(angle);
  
  return new PVector(x, y);
  
}

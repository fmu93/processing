class Flash {
  
  color c;

  Flash() {
    c = color(0);    
  }
  
  color getColor() {
    if (millis()%4 == 0) {
      c = color(0);
    } else {
      c = color(180);
    }
    
    return c;
  }
}

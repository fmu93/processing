class Letter {
  
  ArrayList<Led> leds = new ArrayList<Led>();
 
  Letter() {
    
  }
  
  void addLed(Led led) {
    leds.add(led);
  }
  
  void show() {
    for (Led led : leds) {
      led.signal();
    }
  }
}

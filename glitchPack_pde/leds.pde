class LedSystem { //<>//

  private HashMap<Integer, Led> ledMap;

  //ArrayList<Led> leds = new ArrayList<Led>();
  private ArrayList<Led> ledsToSignal = new ArrayList<Led>();
  // TODO keep track or order of leds

  LedSystem() {
    ledMap = new HashMap<Integer, Led>();
  }

  Led getLed(int _id) {
    if (ledMap.keySet().contains(_id)) {
      return ledMap.get(_id);
    }
    return null;
  }

  //Led[] getLeds(int[] ids) {
  //  Led[] toReturn = new Led[0];
  //  for (int id : ids) {
  //    if (ledMap.keySet().contains(id)) toReturn.add(ledMap.get(id));
  //  }
  //}

  void show2() {
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      int id = (int) iterator.next();
      ledMap.get(id).show();
    }
  }

  String toSocket() {
    String toReturn = ">" + ledMap.size() + "\n";
    //colorMode(RGB, 1.0);
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();

      Led led = ledMap.get(id); 
      toReturn += id + "," +led.getHSB() + "\n"; // id,red,green,blue
    }

    toReturn += "< end <";
    //colorMode(HSB, 1.0);

    return toReturn;
  }

  void rainbow() {
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      Led led = ledMap.get(id); 
      led.setColor(color(((id+millis()/1500)/60.0) % 1.0, 1, 1));
    }
  }

  void show() {    
    Led prev = null;
    //intList set = ledMap.keySet();
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();

      Led led = ledMap.get(id); 
      if (ledsToSignal.contains(led)) {
        led.signal();
      }
      // line between them
      strokeWeight(2);
      if (prev != null) {
        line(prev.pos.x, prev.pos.y, led.pos.x, led.pos.y);
      }
      led.show();
      prev = led;
    }
    ledsToSignal.clear();
  }

  void signal(Led ledToSignal) {
    ledsToSignal.add(ledToSignal);
  }

  void signal2(IntList idList) {
    if (idList != null) {
      for (int id : idList) {
        if (ledMap.keySet().contains(id)) {
          Led led = ledMap.get(id);
          if (led != null) {
            led.setSignalColor();
          }
        }
      }
    }
  }

  void addLed(int id_, PVector pos_) {
    ledMap.put(id_, new Led(pos_, id_));
  }

  void addLed(PVector pos_) {
    ledMap.put(ledMap.size()+1, new Led(pos_, ledMap.size()+1));
    println(ledMap.size());
  }

  IntList isInside(PVector point, float radius) { 
    IntList idsToReturn = new IntList();
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      Led led = ledMap.get(id); 

      if (PVector.sub(led.pos, point).mag() < led.size/2 + radius) {
        idsToReturn.append(id);
      }
    }
    return idsToReturn;
  }

  void updateFlowField() {

    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      Led led = ledMap.get(id);

      float hue = patternSystem.updateLookup(led.pos);

      color c = color(hue, saturation, brightness);

      led.setColor(c);
    }

    if (ledMap.get(0) != null) println(ledMap.get(0).c);
    patternSystem.updateZ();
    patternSystem.evolveSpread();
  }

  IntList isInside(PVector point) {
    return isInside(point, ledSize/2);
  }

  ArrayList<Led> getSelectedLeds() {
    ArrayList<Led> toReturn = new ArrayList<Led>();
    for (int id : ledMap.keySet()) {
      Led led = ledMap.get(id);
      if (led.isSelected)
        toReturn.add(led);
    }
    return toReturn;
  }

  IntList getSelectedIds() {
    IntList toReturn = new IntList();
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      Led led = ledMap.get(id);
      if (led.isSelected)
        toReturn.append(id);
    }
    return toReturn;
  }

  void clearSelection() {
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      Led led = ledMap.get(id);
      led.unSelect();
    }
  }

  void removeLed(int _id) {
    removeLed(ledMap.get(_id));
    //if (ledMap.keySet().contains(_id)) {
    //  ledMap.remove(ledMap.get(_id));
    //}
  }


  void removeLed(Led led) {
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      if (led == ledMap.get(id)) {
        ledMap.remove(id);
        break;
      }
    }
  }

  int ledCount() {
    return ledMap.keySet().size();
  }

  StringList stringList() {
    StringList toPrint = new StringList();
    Iterator iterator = ledMap.keySet().iterator();
    while (iterator.hasNext()) {
      //for (int id : ledMap.valueSet()) {
      int id = (int) iterator.next();
      toPrint.append( "ID:" + id  + "," + ledMap.get(id).pos.x + "," + ledMap.get(id).pos.y);
    }
    return toPrint;
  }
}

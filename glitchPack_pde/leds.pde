class LedSystem { //<>//

  private HashMap<Integer, Led> ledMap;
  private int ledCount = 0;
  private float brightnessFactor = 0;

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
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext())
    {
      Map.Entry<Integer, Led> entry = itr1.next();
      //entry.getKey();
      entry.getValue().show();
    }
  }

  float getAverageBrightness() {
    float sum = 0;
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      sum +=  entry.getValue().getBrightness();
    }

    return sum/ledCount;
  }

  String toSocket() {
    String toReturn = ">" + ledMap.size() + "\n";

    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      toReturn += entry.getKey() + "," + entry.getValue().getHSB() + "\n"; // id,red,green,blue
    }

    toReturn += "< end <";

    return toReturn;
  }

  void rainbow() {
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    float now = millis()/100;
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      entry.getValue().setColor(color(((entry.getKey()+millis()/20.0)/300.0) % 1.0, 1, brightness*map((entry.getKey() +now) % 8, 0, 7, 1, 0.1)));
    }
  }

  void show() {    
    Led prev = null;
    //intList set = ledMap.keySet();

    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      //entry.getKey();
      entry.getValue().signal();

      // line between them
      strokeWeight(2);
      if (prev != null) {
        line(prev.pos.x, prev.pos.y, entry.getValue().pos.x, entry.getValue().pos.y);
      }
      entry.getValue().show();
      prev = entry.getValue();
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
    ledCount = ledMap.size();
  }

  void addLed(PVector pos_) {
    int last = -1;

    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      // the next LED id is skipping
      if (entry.getKey() != last+1) {
        break;
      }

      last = entry.getKey();
    }

    addLed(last+1, pos_);
  }

  IntList isInside(PVector point, float radius) { 
    IntList idsToReturn = new IntList();

    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      if (PVector.sub(entry.getValue().pos, point).mag() < entry.getValue().size/2 + radius) {
        idsToReturn.append(entry.getKey());
      }
    }
    return idsToReturn;
  }

  void updateFlowField() {
    
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      float hue = patternSystem.updateLookup(entry.getValue().pos);
      float bri = patternSystem.brightnessLookup(entry.getValue().pos);


      // shadowFactor = [0-1] -> briStart = [0, 0.5], cutoff = [0, 0.8];


      float briStart = map(shadowFlowFactor, 0, 1, 0, 0.5);
      float cutoff = map(shadowFlowFactor, 0, 1, briStart, 0.8);

      if (bri < cutoff) { // TODO balance algorithim 
        //bri += 0.7;
        //bri = brightness*(1-shadowFlowFactor*pow(bri, 3)); // somehow brightness doesn't look linear in the LEDs
        bri = map(bri, briStart, cutoff, 0, 1);
        bri = pow(bri, 1.5)*brightness;
      } else {
        //bri = map(bri, 0, 1, 0, brightness);
        bri = brightness;
      }
      
      color c = color(hue, saturation, bri);
      //c = evenBrightness(c, brightnessFactor);
      entry.getValue().setColor(c);
    }
    
    brightnessFactor = getAverageBrightness();
  }
  
  color evenBrightness(color c, float factor) {
    factor = map(factor, 0, brightness, 2, 1);
    
    return color(hue(c), saturation(c), constrain(brightness(c)*factor, 0, 1));
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

    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      if (entry.getValue().isSelected)
        toReturn.append(entry.getKey());
    }
    return toReturn;
  }

  void clearSelection() {
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      entry.getValue().unSelect();
    }
  }

  void clearColors() {
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      entry.getValue().setColor(color(0));
    }
  }

  void removeLed(int _id) {
    removeLed(ledMap.get(_id));
    ledCount = ledMap.size();
  }


  void removeLed(Led led) {
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      if (led == entry.getValue()) {
        ledMap.remove(entry.getKey());
        break;
      }
    }
  }

  int ledCount() {
    return ledMap.keySet().size();
  }

  StringList stringList() {
    StringList toPrint = new StringList();
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();

      toPrint.append( "ID:" + entry.getKey()  + "," + entry.getValue().pos.x + "," + entry.getValue().pos.y);
    }
    return toPrint;
  }
}

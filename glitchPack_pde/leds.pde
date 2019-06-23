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
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext())
    {
      Map.Entry<Integer, Led> entry = itr1.next();
      //entry.getKey();
      entry.getValue().show();
    }
  }

  String toSocket() {
    String toReturn = ">" + ledMap.size() + "\n";
    //colorMode(RGB, 1.0);

    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      toReturn += entry.getKey() + "," +entry.getValue().getHSB() + "\n"; // id,red,green,blue
    }

    toReturn += "< end <";
    //colorMode(HSB, 1.0);

    return toReturn;
  }

  void rainbow() {
    Iterator<Map.Entry<Integer, Led>> itr1 = ledMap.entrySet().iterator();
    while (itr1.hasNext()) {
      Map.Entry<Integer, Led> entry = itr1.next();
      entry.getValue().setColor(color(((entry.getKey()+millis()/1500)/60.0) % 1.0, 1, 1));
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
  }

  void addLed(PVector pos_) {
    ledMap.put(ledMap.size()+1, new Led(pos_, ledMap.size()+1));
    println(ledMap.size());
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

      color c = color(hue, saturation, brightness);

      entry.getValue().setColor(c);
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

  void removeLed(int _id) {
    removeLed(ledMap.get(_id));
    //if (ledMap.keySet().contains(_id)) {
    //  ledMap.remove(ledMap.get(_id));
    //}
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

class LetterSystem {

  HashMap<Character, IntList> letterMap = new HashMap<Character, IntList>();
  public float letterDelay = 100; // millis
  float gapDelay = letterDelay;
  String queue = "";
  ArrayList<String> poems = new ArrayList<String>();
  int poemIndex = 0;
  int showIndex = 0;
  int loopCount = 0;
  int loopMax = 2;
  float last = 0;

  //ArrayList<Letter> letters = new ArrayList<Letter>();

  LetterSystem() {
    initPoems();
  }

  void initPoems() {
    poems.add("eddie happy birthday!!");
    //poems.add("1234567890");
    //poems.add(". ");
    setQueue(poems.get(0));
  }

  void evolveQueue() {
    if (frameCount % 1000 == 0 || loopCount >= loopMax) {
      poemIndex = (poemIndex + 1) % poems.size();
      setQueue(poems.get(poemIndex));

      loopCount = 0;
    }
  }

  void setQueue(String _queue) {
    if (_queue.length() > 0) {
      queue = _queue + "  ";
      showIndex = 0;
    } else {
      endQueue();
    }
  }

  void endQueue() {
    queue = "";
  }

  void showQueue() {
    evolveQueue();

    // TODO double letters to flash twice
    if (keyPressed) {
      signalLetter(key);
    } else if (queue.length() > 0 && millis() - last >= gapDelay) {
      //signalLetter(queue.charAt(showIndex));
      fadeLetter(queue.charAt(showIndex));

      if (millis() - last > signalDelay) {
        showIndex = (showIndex + 1) % queue.length();
        last = millis();
      }
    }

    if (showIndex >= queue.length()-1) {
      showIndex = 0;
      loopCount++;
      //last = 0;
    }
  }

  void fadeLetter(char _char) {
    if (getLetterIds(_char) != null && getLetterIds(_char) != null) {
      for (int id : getLetterIds(_char)) {
        Led led = ledSystem.getLed(id);
        if (led != null) led.fadeSignal();
      }
    }
  }

  void signalLetter(char _char) {

    if (getLetterIds(_char) != null && getLetterIds(_char) != null) {
      for (int id : getLetterIds(_char)) {
        Led led = ledSystem.getLed(id);
        if (led != null) led.setSignalColor();
      }
    }
  }

  boolean addLetter(IntList ids, Character letter) {
    if (ids != null) {
      letterMap.put(letter, ids);
      return true;
    }
    return false;
  }

  IntList getLetterIds(char letter) {
    if (letterMap.get(letter) != null) {
      return letterMap.get(letter);
    }
    return null;
  }

  String toSave(char letter) {
    return "["+letterMap.get(letter).join(",")+"]";
  }
}

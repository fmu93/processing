class Mode {
  
  public int totalModes = 4;
  int currentMode = 0;

  Mode(int i) {
    setMode(i);
  }

  void setMode(int i) {
    if (i > totalModes) return;
    currentMode = i;
    
    switch(i) {
    case 0:
      signalDelay = 800;
      fadeDelay = 1;
      signalSaturation = 0.2;
      saturation = 1;
      incFlow = 0.07;
      rateFlow = 0.06;
      incFlow2 = 0.1;
      rateFlow2 = 0.08;
      shadowFlowFactor = 0.7;
      break;

    case 1:
      signalDelay = 800;
      fadeDelay = 1;
      signalSaturation = 0.2;
      saturation = 1;
      incFlow = 0.07;
      rateFlow = 0.06;
      incFlow2 = 0.1;
      rateFlow2 = 0.08;
      shadowFlowFactor = 0.7;
      break;

    case 2:
      signalDelay = 800;
      fadeDelay = 1;
      signalSaturation = 0.2;
      saturation = 1;
      incFlow = 0.07;
      rateFlow = 0.06;
      incFlow2 = 0.1;
      rateFlow2 = 0.08;
      shadowFlowFactor = 0.7;
      break;
    }
  }
  
  void nextMode() {
    int newMode = (currentMode+1) % totalModes;
    setMode(newMode);
  }

  void printMode() {
    println("Printing variables for mode... \n");
    println("signalDelay = " + signalDelay + ";");
    println("fadeDelay = " + fadeDelay + ";");
    println("signalSaturation = " + signalSaturation + ";");
    println("saturation = " + saturation + ";");
    println("incFlow = " + incFlow + ";");
    println("rateFlow = " + rateFlow + ";");
    println("incFlow2 = " + incFlow2 + ";");
    println("rateFlow2 = " + rateFlow2 + ";");
    println("shadowFlowFactor = " + shadowFlowFactor + ";");
    println("");
  }
}

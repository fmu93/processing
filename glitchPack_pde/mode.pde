class Mode {

  public int totalModes = 9;
  int currentMode = 0;

  Mode(int i) {
    setMode(i);
  }

  void setMode(int i) {
    if (i > totalModes) return;
    currentMode = i;

    switch(i) {
    case 0:
      lettersOn = false;
      flowOn = true;
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
      lettersOn = false;
      flowOn = true;
      signalDelay = 800.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.027999928;
      rateFlow = 0.010999966;
      incFlow2 = 0.05549991;
      rateFlow2 = 0.08750001;
      shadowFlowFactor = 1.2249995;
      break;

    case 2:
      lettersOn = false;
      flowOn = true;
      signalDelay = 800.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.06349999;
      rateFlow = 0.02;
      incFlow2 = 0.05549991;
      rateFlow2 = 0.014999926;
      shadowFlowFactor = 0.4;
      break;

    case 3:
      lettersOn = false;
      flowOn = true;
      signalDelay = 800.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.017499946;
      rateFlow = 0.05049998;
      incFlow2 = 0.14799975;
      rateFlow2 = 0.014999926;
      shadowFlowFactor = 0.5583335;
      break;

    case 4:
      lettersOn = true;
      flowOn = true;
      signalDelay = 656.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.017499946;
      rateFlow = 0.05049998;
      incFlow2 = 0.13799988;
      rateFlow2 = 0.014999926;
      shadowFlowFactor = 1.0749997;
      break;

    case 5:
      lettersOn = true;
      flowOn = true;
      signalDelay = 896.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.032499924;
      rateFlow = 0.03549995;
      incFlow2 = 0.15049972;
      rateFlow2 = 0.037999913;
      shadowFlowFactor = 0.8083333;
      break;

    case 6:
      lettersOn = true;
      flowOn = true;
      signalDelay = 230.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.032999925;
      rateFlow = 0.027999947;
      incFlow2 = 0.075499944;
      rateFlow2 = 0.058999956;
      shadowFlowFactor = 1.0499997;
      break;

    case 7:
      lettersOn = false;
      flowOn = true;
      signalDelay = 230.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.10550007;
      rateFlow = 0.027999947;
      incFlow2 = 0.15049972;
      rateFlow2 = 0.12050008;
      shadowFlowFactor = 0.6;
      break;

    case 8:
      lettersOn = false;
      flowOn = true;
      signalDelay = 230.0;
      fadeDelay = 1.0;
      signalSaturation = 0.2;
      saturation = 1.0;
      incFlow = 0.05549997;
      rateFlow = 0.07550003;
      incFlow2 = 0.08649997;
      rateFlow2 = 0.011999926;
      shadowFlowFactor = 0.5166669;
      break;
    }
  }

  void nextMode() {
    int newMode = (currentMode+1) % totalModes;
    setMode(newMode);
  }

  void printMode() {
    println("Printing variables for mode... \n");
    println("lettersOn = " + lettersOn + ";");
    println("flowOn = " + flowOn + ";");
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

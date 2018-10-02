class LSystem {

  String sentence;
  Rule[] ruleset;
  int generation;

  LSystem(String axiom, Rule[] r) {
    sentence = axiom;
    ruleset = r;
  }

  void generate() {
    StringBuffer nextgen = new StringBuffer();
    for (int i = 0; i < sentence.length(); i++) {
      char c = sentence.charAt(i);
      // replace it with itself unless matching in ruleset
      String replace = "" + c;
      // check every rule
      for (int j = 0; j < ruleset.length; j++) {
        char a = ruleset[j].getA();
        if (c == a) {
          replace = ruleset[j].getB();
          break;
        }
      }
      // append replacement string
      nextgen.append(replace);
    }
    // replace sentence
    sentence = nextgen.toString();
    // Increment generation
    generation++;
  }

  String getSentence() {
    return sentence;
  }

  int getGeneration() {
    return generation;
  }
}

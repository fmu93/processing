class Turtle {

  String todo;
  float len;
  float theta;

  Turtle(String s, float l, float t) {
    todo = s;
    len = l;
    theta = t;
  }

  void render() {
    for (int i = 0; i < todo.length(); i++) {
      char c = todo.charAt(i);
      switch(c) {
      case 'F':
        line(0, 0, len, 0);
        translate(len, 0);
        break;
      case 'G':
        translate(len, 0);
        break;
      case '+':
        rotate(theta);
        break;
      case '-':
        rotate(-theta);
        break;
      case '[':
        pushMatrix();
        break;
      case ']':
        popMatrix();
        break;
      }
    }
  }

  void setToDo(String t) {
    todo = t;
  }

  void changeLen(float ratio) {
    len *= ratio;
  }
}

class Health_Refill {
  int x;
  int y;
  int w1;
  int h1;
  int w2;
  int h2;
  color c;

  // declaring the refill hitbox variables
  int top;
  int left;
  int right;
  int bottom;

  // constructor
  Health_Refill(int xNum, int yNum, int w1Num, int h1Num, int w2Num, int h2Num, color aColor) {
    x = xNum;
    y = yNum;
    w1 = w1Num;
    h1 = h1Num;
    w2 = w2Num;
    h2 = h2Num;
    c = aColor;

    top = y - (h2/ 2);
    left = x - (w1 / 2);
    right = x + (w1 / 2);
    bottom = y + (h2 / 2);
  }

  ///////////////////////////////
  // REFILL FUNCTION DEFINITIONS
  ///////////////////////////////

  /* draws the health refill */
  void render() {
    fill(c);
    rect(x, y, w1, h1);
    rect(x, y, w2, h2);
  }
}

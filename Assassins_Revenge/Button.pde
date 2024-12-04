class Button {
  // button variables
  int x;
  int y;
  int w;
  int h;
  int c;
  int radius; // represents the radisu of the rounded corners of the buttons
  
  // button hit box variables
  int top;
  int bottom;
  int left;
  int right;
  
  // represents wether or not a button was clicked on
  boolean isColliding;
  
  // constructor
  Button(int startX, int startY, int wNum, int hNum, int aColor) {
    x = startX;
    y = startY;
    w = wNum;
    h = hNum;
    c = aColor;
    radius = 5;
    
    // initializing the button hitbox variables
    top = y - (h / 2);
    bottom = y + (h / 2);
    left = x - (w / 2);
    right = x + (w / 2);
  }
  
  ////////////////////////////////
  // BUTTON FUNCTION DEFINITIONS
  ////////////////////////////////
  
  /* draws a button */
  void render() {
    fill(c);
    rect(x, y, w, h, radius);
  }
  
  /* determines wether or not a button is colliding with the mouse */
  void isColliding() {
    if (mouseY <= bottom &&
      mouseY >= top &&
      mouseX >= left &&
      mouseX <= right) {

      isColliding = true;
    }
    else isColliding = false;
  }
}

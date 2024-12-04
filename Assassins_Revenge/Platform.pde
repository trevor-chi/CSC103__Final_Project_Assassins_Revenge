class Platform {
  // platform variables
  int x;
  int y;
  int h;   // height
  int w;   // width
  color c;

  // represents the platforms hitbox
  int top;
  int left;
  int right;
  int bottom;
  
  /* declaring an image variable that represents
  the image of all of the platforms */
  PImage platformImage;

  // Platform constructor to initialize the variables
  Platform(int platX, int platY, int widthNum, int heightNum, color aColor) {
    x = platX;
    y = platY;
    h = heightNum;
    w = widthNum;
    c = aColor;

    // initializing my platform hitbox variables
    top = y - (h/ 2);
    left = x - (w / 2);
    right = x + (w / 2);
    bottom = y + h / 2;
    
    platformImage = loadImage("wall.jpg");
    platformImage.resize(w, h);
  }

  //////////////////////////////////////////
  // PLATFORM FUNCTION DEFINITIONS
  //////////////////////////////////////////

  // renders the platforms
  void render() {
    fill(c);
    image(platformImage, x, y, w, h);
  }

  /* detect if the player has collided with the platform and if so,
   stop the player from moving through the platform wether that is from
   the sides or the top */
  void collideWithPlayer(Player aPlayer) {
    /* represents how far the player must move past a platform (while on top of it) to be pushed off.
     allows for the falling motion when walking off of a platform to be smoother and less snappy. 25
     was found to be a good threshold after some play testing */
    int playerFallOffThreshold = 25;

    /* represents how far the player must be from the side of a platform for
     the players movement to be restricted. Having the player stop once they are one pixel from
     the platform stops the player from being able to stick to the side of a platform by clipping
     into it by reapeating side to side movement */
    int playerStopThreshold = 1;

    /* if the player collides with the left side of a platform,
     then stop the player from moving right */
    if (aPlayer.top <= bottom &&
      aPlayer.bottom >= top &&
      aPlayer.right > left &&
      aPlayer.left <= left - playerFallOffThreshold) {

      aPlayer.isMovingRight = false;
      aPlayer.x = left - aPlayer.size/2 - playerStopThreshold;
    }

    /* if the player collides with the right side of a platform,
     then stop the player from moving left */
    if (aPlayer.top <= bottom &&
      aPlayer.bottom >= top &&
      aPlayer.left < right &&
      aPlayer.right >= right + playerFallOffThreshold) {

      aPlayer.isMovingLeft = false;
      aPlayer.x = right + aPlayer.size/2 + playerStopThreshold;
    }

    /* if the player collides with the top of a platform,
     then stop the player from falling */
    if (left < aPlayer.right &&
      right > aPlayer.left &&
      top <= aPlayer.bottom &&
      bottom > aPlayer.top) {

      aPlayer.isFalling = false;
    }
   
    /* if the player collides with the bottom of 
    a floating platform then make the player fall */
    if (aPlayer.left <= right &&
        aPlayer.right >= left &&
        aPlayer.top < bottom &&
         aPlayer.bottom >= bottom + playerFallOffThreshold) {
        
        aPlayer.isFalling = true;
        aPlayer.isJumping = false;
    }
  }
}

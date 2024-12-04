import processing.sound.*;
class Player {
  // player variables
  int x;
  int y;
  int size;
  int moveSpeed;
  int jumpHeight;  // distance that the player jumps
  int maxJumpY;   // y value of the max jump height
  int damage;  // represents the amount of damage that the player does when attacking
  int health;  // represents the amount of health that the player has
  PImage assassinRight;
  PImage assassinLeft;
  color c;

  // declaring an animation variable for my assassin running to the right animation
  Animation runRightAnimation;

  // declaring an animation variable for my assassin running to the left animation
  Animation runLeftAnimation;

  // declaring an animation variable for my assassin attacking while facing right
  Animation attackRightAnimation;
  
  // declaring an animation variable for my assassin attacking while facing left 
  Animation attackLeftAnimation;

  // declaring an animation variable for my assassin jumping while facing right animation
  Animation jumpingRightAnimation;
  
  // declaring an animation variable for my assassin jumping while facing left animation
  Animation jumpingLeftAnimation;

  // declaring an animation variable for my assassin being hit
  Animation hurtAnimation;

  // initializing my array of images for my runningright animation
  PImage[] runRightImages = new PImage[5];

  // initializing my array of image for my running left animation
  PImage[] runLeftImages = new PImage[5];

  // initializing array of images for attacking while facing right animation
  PImage[] attackRightImages = new PImage[3];
  
  // initializing my array of images for my attacking while facing left animation
  PImage[] attackLeftImages = new PImage[3];

  // initializing an array of images for the jumping while facing right animation
  PImage[] jumpingRightImages = new PImage[2];
  
  // initializing an array of images for the jumping while facing left animation
  PImage[] jumpingLeftImages = new PImage[2];

  // initializing array of images for hurt animation
  PImage[] hurtImages = new PImage[2];

  // represents whether not the player is moving left or right
  // boolean style is used for seamless player movement
  boolean isMovingRight;  // intialize as false so that the player is stationary at the start of the game
  boolean isMovingLeft;

  // represents whether or not the player is facing left or right
  boolean isFacingLeft;
  boolean isFacingRight;

  // represents whether or not the player is jumping or falling
  boolean isJumping;
  boolean isFalling;

  // represents whether or not the player is attacking
  boolean isAttacking;

  // represents wether or not the player was reset in level three
  boolean wasReset;

  // represents whether ot not the player is colliding with an enemies attack hitbox
  boolean collidingWithAttackHitBox;

  // represents whether or not the player is colliding with a health refills hit box
  boolean collidingWithRefillHitBox;

  // represents whether or not the player is dead
  boolean isDead;

  // declaring my player hitbox variables
  int top;
  int bottom;
  int left;
  int right;

  // declaring my player attack hitbox variables
  int attackTop;
  int attackLeft;
  int attackRight;
  int attackBottom;

  // Player constructor to initialize the variables
  Player(int startX, int startY, int bulk, int speed, int damageAmt, int healthAmt, color aColor) {
    x = startX;
    y = startY;
    size = bulk;
    moveSpeed = speed;
    jumpHeight = 100;
    maxJumpY = y - jumpHeight;
    damage = damageAmt;
    health = healthAmt;
    c = aColor;

    // initializing all the player movement boolean variables
    isMovingLeft = false;
    isMovingRight = false;
    isFacingLeft = false;
    isFacingRight = true;
    isJumping = false;
    isFalling = false;

    // initializing the player attack boolean variable
    isAttacking = false;

    // initializing the was reset boolean variable
    wasReset = false;

    // initializing the player colliding with enemy attack box variable
    collidingWithAttackHitBox = false;

    // initializing the player is dead variable
    isDead = false;

    // initializing all the player hitbox variables
    top = y - (size / 2);
    bottom = y + (size / 2);
    left = x - (size / 2);
    right = x + (size / 2);

    // initializing all the player attack hitbox variables
    attackTop = top + (size / 2);
    attackLeft = left - (size / 2);
    attackRight = right + (size / 2);
    attackBottom = bottom;

    /* loading and scaling my assassin facing right image */
    assassinRight = loadImage("rogue.png");
    assassinRight.resize(size + 100, size + 100);

    /* loading and scaling my assassin facing left image */
    assassinLeft = loadImage("rogueLeft.png");
    assassinLeft.resize(size + 100, size + 100);

    // loading all of the images for my running right animation
    for (int i = 0; i < runRightImages.length; i++) {
      runRightImages[i] = loadImage("run" + i + ".png");
    }

    // loading all of the images for my assassin running left animation
    for (int i = 0; i < runLeftImages.length; i++) {
      runLeftImages[i] = loadImage("runLeft" + i + ".png");
    }

    // loading all of the images for my attacking while facing right animation
    for (int i = 0; i < attackRightImages.length; i++) {
      attackRightImages[i] = loadImage("PlayerAttack" + i + ".png");
    }
    
    // loading all of my images for my attacking while facing left animation
     for (int i = 0; i < attackLeftImages.length; i++) {
      attackLeftImages[i] = loadImage("PlayerAttackLeft" + i + ".png");
    }

    // loading all of the images for my jumping animation
    for (int i = 0; i < jumpingRightImages.length; i++) {
      jumpingRightImages[i] = loadImage("jump" + i + ".png");
    }
    
    // loading all of the images for my jumping while facing left animation
    for (int i = 0; i < jumpingLeftImages.length; i++) {
      jumpingLeftImages[i] = loadImage("jumpLeft" + i + ".png");
    }

    // initializing my run right animation
    runRightAnimation = new Animation(runRightImages, 0.2, 1);

    // initializing my run left animation
    runLeftAnimation = new Animation(runLeftImages, 0.2, 1);

    // initializing my attacking while facing right animation
    attackRightAnimation = new Animation(attackRightImages, 0.2, 1);
    
    // initializing my attacking while facing left animation
    attackLeftAnimation = new Animation(attackLeftImages, 0.2, 1);

    // initializing my jumping while facing right  animation
    jumpingRightAnimation = new Animation(jumpingRightImages, 0.05, 1);
    
    // initializing my jumping while facing left animation
    jumpingLeftAnimation = new Animation(jumpingLeftImages, 0.05, 1);
  }

  ////////////////////////////////////////////////////
  // PLAYER FUNCTION DEFINITIONS
  ////////////////////////////////////////////////////

  /* renders the player and all of the player animations */
  void render() {
    fill(c);
    /* if the assassin is facing right then display the assassin facing right */
    if (isMovingLeft == false && isMovingRight == false && isFacingRight == true && isJumping == false && isAttacking == false && isFalling == false) {
      image(assassinRight, x + 20, y - 30);
    }
    /* if the assassin is facing left then display the assassin facing left */
    else if (isMovingLeft == false && isMovingRight == false && isFacingLeft == true && isJumping == false && isAttacking == false && isFalling  == false || x <= (0 + size / 2) && isFacingRight == true) {
      image(assassinLeft, x - 20, y - 30);
    }
    /* if the player jumps then display the jump animation */
    else if (jumpingRightAnimation.isAnimating == true && isAttacking == false) {
      jumpingRightAnimation.display(x + 20, y - 30);
    }
    else if (jumpingLeftAnimation.isAnimating == true && isAttacking == false) {
      jumpingLeftAnimation.display(x - 20, y - 30);
    }
    /* if the player presses the d key then display the running to the right animation */
    else if (runRightAnimation.isAnimating == true && isJumping == false && isFalling == false) {
      runRightAnimation.display(x + 20, y - 30);
    }
    /* if the player presses the w key then display the running to the left animation */
    else if (runLeftAnimation.isAnimating == true && isJumping == false && isFalling == false) {
      runLeftAnimation.display(x - 20, y - 30);
    }
    /* if the player is falling and facing right then display the right image*/
    else if (isFalling == true && isAttacking == false && isFacingRight == true) {
      image(assassinRight, x + 20, y - 30);
    }
    /* if the player is falling and facing left then display the left image */
    else if (isFalling == true && isAttacking == false && isFacingLeft == true) {
      image(assassinLeft, x - 20, y - 30);
    } 
    /* if the player is facing right then display the right image */
    else if (isFacingRight == true) {
      image(assassinRight, x + 20, y - 30);
    } 
    /* if the player is facing left then display the left image */
    else if (isFacingLeft == true) {
      image(assassinLeft, x - 20, y - 30);
    }
  }

  /* renders the players health amt */
  void renderHealth() {
    fill(#2FD0EA);
    rect(525, 60, 400, 115, 5);
    fill(0);
    textSize(75);
    text("Health: " + health, 350, 70);
  }

  // handles the players side to side movement, and the updating of the players hitbox
  void move() {

    // adding my hitbox variables into the move function so that they update as the player moves
    top = y - (size / 2);
    bottom = y + (size / 2);
    left = x - (size / 2);
    right = x + (size / 2);

    // adding the attack hitbox variables so that they update as the player moves
    attackTop = top - (size / 2);
    attackLeft = left - (size / 2);
    attackRight = right + (size / 2);
    attackBottom = bottom;

    // handling the move feature
    if (isMovingLeft == true && x >= (0 + size / 2)) {
      x -= moveSpeed;
    } else if (isMovingRight == true) {
      x += moveSpeed;
    }
  }

  // handles the players jumping feature and updates the hitbox
  void jump() {
    if (isJumping == true) {
      y -= moveSpeed;
    }
  }

  // makes the player fall after a jump or after walking off a platform
  void fall() {
    if (isFalling == true) {
      y += moveSpeed;
    }
  }

  // makes the player fall back down after the max jump height is reached
  void topOfJump() {
    if (y <= maxJumpY) {
      isJumping = false;
      isFalling = true;
    }
  }

  // makes the player stop falling after the player lands back on the ground
  void land() {
    if (y >= height - size / 2) {
      isFalling = false;
    }
  }

  /* check to see if the player is colliding with a platform,
   if the player is not colliding with a platform, then make
   the player start falling */
  void fallOffPlatform(ArrayList<Platform> aPlatformList) {

    /* check that the player is not in the middle of a jump
     and that the player is not already on the ground */
    if (isJumping == false && y < height - size / 2) {

      // represents whether or not the player is currently on a platform
      boolean onPlatform = false;

      // loops through all platforms in the list
      for (Platform aPlatform : aPlatformList) {
        // if the player is on the top of a platform then make onPlatform true
        if (top <= aPlatform.bottom &&
          bottom >= aPlatform.top &&
          left <= aPlatform.right &&
          right >= aPlatform.left) {
          onPlatform = true;
          isJumping = false;
          isFalling = false;
        }
      }

      // if the player is not on the platform then make the player fall
      if (onPlatform == false) {
        isFalling = true;
      }
    }
  }

  /* stops the player from moving off the opposite side of the screen
   if all of the enemies have not been destroyed */
  void restrictMovement(ArrayList aList) {
    if (!aList.isEmpty() && x >= width || y < 500 && x >= width) {
      isMovingRight = false;
      x = width - (size / 6);
    }
  }

  /* resets the player to the the left side of the window
   if they fall to the ground while their x is above a certain
   value. this method is used in level three to stop the player
   from being stuck between the taller platforms */
  void resetPosition() {
    int startingY = 685;  // represents the y position of the player when they are resting on the ground
    int startingX = 50;  // represents the x position of teh player when they are at the start of a level

    /* make sure the player x is also less than the x of the last
     platform so that the player can fall down to the last enemy
     of level three */
    if (x > 420 && y >= startingY && x < 900) {
      x = startingX;
      wasReset = true;
    }
  }

  /* detects whether or not the player is colliding with an enemies attack hitbox */
  void isCollidingWithEnemyAttack(Enemy anEnemy) {

    /* if an enemie's attack box collides with the player from the
     right side of the player, then allow the enemy to attack */
    if (anEnemy.attackTop <= bottom &&
      anEnemy.attackBottom >= top &&
      anEnemy.attackRight >= left &&
      anEnemy.attackLeft <= right) {

      //collidingWithAttackHitBox = true;
      anEnemy.isCollidingWitPlayer = true;
    }

    /* if an enemies attack box collides with the player from the
     left side of the player, then allow the enemy to attack */
    if (anEnemy.attackTop <= bottom &&
      anEnemy.attackBottom >= top &&
      anEnemy.attackLeft <= right &&
      anEnemy.attackRight >= left) {

      //collidingWithAttackHitBox = true;
      anEnemy.isCollidingWitPlayer = true;
    }

    /* if an enemies attack box collides with the player from the
     bottom of the player, then allow the enemy to attack */
    if (left < anEnemy.attackRight &&
      right > anEnemy.attackLeft &&
      top <= anEnemy.attackBottom &&
      bottom >= anEnemy.attackTop) {


      //collidingWithAttackHitBox = true;
      anEnemy.isCollidingWitPlayer = true;
    } else anEnemy.isCollidingWitPlayer = false;//collidingWithAttackHitBox = false;
  }

  /* detects whether or not the player is colliding with a health refills hitbox */
  void isCollidingWithHealthRefill(Health_Refill aRefill) {

    /* if a refills hit box collides with the player from the
     right side of the player, then return true */
    if (aRefill.top <= bottom &&
      aRefill.bottom >= top &&
      aRefill.right >= left &&
      aRefill.left <= right) {

      collidingWithRefillHitBox = true;
    }

    /* if a refills hit box collides with the player from the
     left side of the player, then return true */
    if (aRefill.top <= bottom &&
      aRefill.bottom >= top &&
      aRefill.left <= right &&
      aRefill.right >= left) {

      collidingWithRefillHitBox = true;
    }

    /* if a refills hit box collides with the player from the
     bottom of the player, then return true */
    if (left < aRefill.right &&
      right > aRefill.left &&
      top <= aRefill.bottom &&
      bottom >= aRefill.top) {


      collidingWithRefillHitBox = true;
    } else collidingWithRefillHitBox = false;
  }

  /* if the player is colliding with a health refill then
   refill the players health back to full */
  void hasBeenRefilled() {
    int startingHealth = 300; //represents the starting health of the player

    if (collidingWithRefillHitBox == true) {
      health = startingHealth;
      if (refill.isPlaying() == false) {
        refill.play();
      }
    }
  }

  /* if the player is attacked by an enemy then the
   players health bar is updates accordingly */
  void hasBeenAttacked(Enemy anEnemy) {
    if (anEnemy.isCollidingWitPlayer == true && (currentTime - startTime > enemyAttackInterval)) {
      health -= anEnemy.damage;
      startTime = millis();
      anEnemy.enemyAttack.isAnimating = true;
      
      /* play the grunt sound file */
      if (grunt.isPlaying() == false) {
        grunt.play();
      }
    }
  }

  /* if the players health is less than or equal to zero
   then make the player die */
  void playerDeath() {
    if (health <= 0) {
      isDead = true;
    }
  }

  /* if the mouse is pressed then make the
   players attack animation run */
  void attackAnimationBoolean() {
    if (mousePressed == true && isFacingRight == true) {
      attackRightAnimation.isAnimating = true;
      isAttacking = true;
      
      /* play the attack sound */
      if (slice.isPlaying() == false) {
        slice.play();
      }
    }
    else if (mousePressed == true && isFacingLeft == true) {
      attackLeftAnimation.isAnimating = true;
      isAttacking = true;
      
       /* play the attack sound */
      if (slice.isPlaying() == false) {
        slice.play();
      }
    }
  }

  /* if the attack animation is animating,
   then run the animation depending one which direction the player is facing */
  void animateAttack() {
    if (attackRightAnimation.isAnimating == true) {
      attackRightAnimation.display(x + 20, y - 30);
    }
    else if (attackLeftAnimation.isAnimating == true) {
      attackLeftAnimation.display(x - 20, y - 30);
    }
  }
}

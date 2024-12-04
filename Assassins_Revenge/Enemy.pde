class Enemy {
  // enemy variables
  int x;
  int y;
  int size;
  int health; // represents the health of an enemy
  int damage; // represents the amount of damage that an enemy does
  int healthBarAmt; // represents the length of the enemies health bar
  int originalX; // represents the original x position that the enemy spawned in at
  int speed = int(random(1, 4)); // represents the movement speed of an enemy
  color c;

  // declaring enemy hitbox variables
  int top;
  int left;
  int right;
  int bottom;

  // declaring enemy attack hitbox variables
  int attackTop;
  int attackLeft;
  int attackRight;
  int attackBottom;

  // represents whether or not an enemy is cdolliding with the player's attack hitbox
  boolean isCollidingWithPlayerAttackBox;
  // represents whether the enemy is colliding with the player (aka should enemy hit player)
  boolean isCollidingWitPlayer;

  // represents whether or not an enemy is moving left or right
  boolean isMovingLeft;
  boolean isMovingRight;

  // declaring my image variables
  PImage enemyImage;

  // declaring the animation for my enemy attack
  Animation enemyAttack;

  // initializing my array of images for my enemy animation
  PImage[] attackImages = new PImage[3];

  // enemy constructor to initialize the enemy variables
  Enemy(int startX, int startY, int bulk, int healthAmt, int damageAmt, int aColor, int beginningX) {
    x = startX;
    y = startY;
    size = bulk;
    health = healthAmt;
    damage = damageAmt;
    healthBarAmt = bulk;
    originalX = beginningX;

    c = aColor;

    // initializing all the enemy hitbox variables
    top = y - (size / 2);
    bottom = y + (size / 2);
    left = x - (size / 2);
    right = x + (size / 2);

    // initializing the enemy attack hitbox variables
    attackTop = top - (size / 2);
    attackLeft = left - (size / 2);
    attackRight = right + (size / 2);
    attackBottom = bottom;

    // initializing the enemy boolean variables
    isCollidingWithPlayerAttackBox = false;
    isMovingLeft = false;
    isMovingRight = true;

    // initializing my image variable
    enemyImage = loadImage("Mummy.png");
    enemyImage.resize(size + 50, size + 50);

    // loading all of the images for the enemy attaack animation
    for (int i = 0; i < attackImages.length; i++) {
      attackImages[i] = loadImage("Attack" + i + ".png");
    }

    // initializing my enemy attack animation
    enemyAttack = new Animation(attackImages, 0.1, 1.2);
  }

  ///////////////////////////////////
  // ENEMY FUNCTION DEFINITIONS
  ///////////////////////////////////

  // draws the enemies
  void render() {
    fill(c);
    if (y < 650 && enemyAttack.isAnimating == false) {
      image(enemyImage, x - 15, y - 25);
    } else if (y > 650 && enemyAttack.isAnimating == false) {
      image(enemyImage, x - 20, y - 35);
    }
  }

  // handles the enemies oscillating movement
  void move() {
    /* including the enemy hitbox variables in the
     move function so that the hitbox moves along with the enemy */
    top = y - (size / 2);
    bottom = y + (size / 2);
    left = x - (size / 2);
    right = x + (size / 2);

    /* if isMovingLeft is true then move left.
     if isMovingRight is true then move right. */
    if (isMovingLeft == true) {
      x -= speed;
    } else if (isMovingRight == true) {
      x += speed;
    }
  }

  /* changes the enemies moving variables back and forth so
   that the enemies have an automatic oscillating movement */
  void oscillateVariables() {
    if (x <= (originalX - 30)) {
      isMovingLeft = false;
      isMovingRight = true;
    }
    if (x >= (originalX + 30)) {
      isMovingRight = false;
      isMovingLeft = true;
    }
  }

  /* draws an enemies health bar */
  void renderHealthBar() {
    fill(c);
    rect(x, (y - size - 20), healthBarAmt, 5);
  }

  /* detects whether or not the enemy is colliding with the players attack hitbox */
  void isCollidingWithPlayerAttack(Player aPlayer) {

    /* if the players attack box collides with the enemy from the
     right side, then allow the player to attack */
    if (aPlayer.attackTop <= bottom &&
      aPlayer.attackBottom >= top &&
      aPlayer.attackRight >= left &&
      aPlayer.attackLeft <= left) {

      isCollidingWithPlayerAttackBox = true;
    }

    /* if the players attack box collides with the enemy from the
     left side, then allow the player to attack */
    if (aPlayer.attackTop <= bottom &&
      aPlayer.attackBottom >= top &&
      aPlayer.attackLeft <= right &&
      aPlayer.attackRight >= right) {

      isCollidingWithPlayerAttackBox = true;
    }

    /* if the players attack box collides with the enemy from the
     top, then allow the player to attack */
    if (left < aPlayer.attackRight &&
      right > aPlayer.attackLeft &&
      top <= aPlayer.attackBottom &&
      bottom >= aPlayer.attackTop) {

      isCollidingWithPlayerAttackBox = true;
    } else isCollidingWithPlayerAttackBox = false;
  }

  /* if the enemy is hit by the player, the
   enemies health bar updates respectively */
  void updateHealthBar() {
    if (isCollidingWithPlayerAttackBox == true && mousePressed == true) {
      if (size == 30) {
        healthBarAmt = (healthBarAmt / 2);
        delay(100);
      } else if (size == 50) {
        healthBarAmt -= (healthBarAmt / 3);
        delay(100);
      } else if (size == 60) {
        healthBarAmt -= (healthBarAmt / 4);
        delay(100);
      } else if (size == 70) {
        healthBarAmt -= (healthBarAmt / 10);
        delay(100);
      }
    }
  }

/* display the enemy attack animation when an enemy attacks */
  void attackAnimation() {
    if (enemyAttack.isAnimating == true) {
      if (y < 650) {
        enemyAttack.display(x - 15, y - 35);
      } else if (y > 650) {
        enemyAttack.display(x - 15, y - 35);
      }
    }
  }
}

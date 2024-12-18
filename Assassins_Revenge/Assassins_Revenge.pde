import processing.sound.*;

// Assassin's Revenge by Trevor Childers

// SOURCES
// all sprites came from https://craftpix.net/all-game-assets/
// all background images and platform images were generated by microsoft copilot and google gemini
// all sounds came from https://freesound.org/ && https://www.soundgator.com/ && https://www.zapsplat.com/basic-member-home/

// Global Variables

// represents the player
Player assassin;

// represents a platform
// level one
Platform plat1;
Platform plat2;
Platform plat3;
Platform plat4;

// level two
Platform plat5;
Platform plat6;
Platform plat7;
Platform plat8;
Platform plat9;
Platform plat19;

// level three
Platform plat10;
Platform plat11;
Platform plat12;
Platform plat13;
Platform plat14;
Platform plat15;

// final level
Platform plat16;
Platform plat17;
Platform plat18;

/* represents a platform that is "floating" above the others.
 Provides additional jump ups for the player to access health upgrades */
// level one
Platform floatingPlat1;
Platform floatingPlat2;
Platform floatingPlat3;
Platform floatingPlat4;
Platform floatingPlat12;
Platform floatingPlat13;
Platform floatingPlat14;
Platform floatingPlat15;
Platform floatingPlat16;
Platform floatingPlat17;

// level two
Platform floatingPlat5;
Platform floatingPlat6;
Platform floatingPlat7;
Platform floatingPlat8;
Platform floatingPlat9;
Platform floatingPlat10;
Platform floatingPlat11;

// represents an enemy
// level one
Enemy e1;
Enemy e2;
Enemy e3;

// level two
Enemy e4;
Enemy e5;
Enemy e6;
Enemy e7;
Enemy e8;
Enemy e13;

// level three
Enemy e9;
Enemy e10;
Enemy e11;
Enemy e12;

// boss enemy
Enemy boss;

// represents a health refill in the game
// tutorial screen refill used as an example
Health_Refill refillExample;

// level one
Health_Refill refill1;

// level Two
Health_Refill refill2;

// final level
Health_Refill refill3;

// represents a button on the start screen
Button startButton;
Button tutorialButton;
Button backstoryButton;
Button tutorialBackToMenuButton;
Button storyBackToMenuButton;

/* declaring a list of health_refills to represent all of
 the refills throughout the game. Changes dynamically as refills
 are added or removed */
ArrayList<Health_Refill> refillList;

/* declaring a list of platforms to represent all the platforms throughout
 the game. Changes dynamically as platforms are added or removed */
ArrayList<Platform> platformList;

/* declaring a list of enemies to represent all of the enemies throughout
 the game. Changes dynamically as enemies are added or removed */
ArrayList<Enemy> enemyList;

/* declaring a list that always contains all of the enemies in the
 entire game. Used in the enemy health reset method to reset the
 health of all enemies */
ArrayList<Enemy> fullEnemyList;

/* declaring a list of all of the buttons on the start screen to help
 condense button functions throughout the program */
ArrayList<Button> buttonList;

// state machine variables
int state = 0;

// millis timer variables
int startTime;  // represents the start time of the program
int currentTime;  // represents the current time within the program
int enemyAttackInterval = 3000;  // represents an interval for which enemies attack on

// image variables
// menu background image
PImage menuBackground;
PImage streetOne;
PImage streetTwo;
PImage dunes;
PImage palace;
PImage deathScreen;
PImage gameCompleteScreen;

// sound variables
SoundFile ambiance;
SoundFile levelMusic;
SoundFile bossMusic;
SoundFile grunt;
SoundFile death;
SoundFile slice;
SoundFile refill;
SoundFile gameComplete;

// setup
void setup() {
  size(1100, 700);
  imageMode(CENTER);
  rectMode(CENTER);  // makes rectangles be drawn from the center
  startTime = millis();  // starts the timer when the program is run

  /* intializing my global variables */
  // player
  assassin = new Player(50, 650, 30, 3, 50, 300, color(0, 255, 0));

  // level one platforms and floating platforms
  plat1 = new Platform(650, height, 100, 200, color(#989D75));
  plat2 = new Platform(500, height, 100, 100, color(#989D75));
  plat3 = new Platform(300, height, 100, 100, color(#989D75));
  plat4 = new Platform(800, height, 100, 100, color(#989D75));
  floatingPlat1 = new Platform(850, 550, 100, 20, color(#989D75));
  floatingPlat2 = new Platform(750, 475, 100, 20, color(#989D75));
  floatingPlat3 = new Platform(850, 400, 100, 20, color(#989D75));
  floatingPlat4 = new Platform(750, 325, 100, 20, color(#989D75));
  floatingPlat12 = new Platform(450, 325, 100, 20, color(#989D75));
  floatingPlat13 = new Platform(150, 325, 100, 20, color(#989D75));
  floatingPlat14 = new Platform(50, 250, 100, 20, color(#989D75));
  floatingPlat15 = new Platform(200, 185, 100, 20, color(#989D75));
  floatingPlat16 = new Platform(500, 185, 100, 20, color(#989D75));
  floatingPlat17 = new Platform(925, 185, 350, 20, color(#989D75));

  // level two platforms and floating platforms
  plat5 = new Platform(150, height, 100, 100, color(#989D75));
  plat6 = new Platform(275, height, 100, 200, color(#989D75));
  plat7 = new Platform(400, height, 100, 300, color(#989D75));
  plat8 = new Platform(550, height, 100, 150, color(#989D75));
  plat9 = new Platform(900, height, 100, 50, color(#989D75));
  plat19 = new Platform(700, height, 50, 50, color(#989D75));
  floatingPlat5 = new Platform(675, 570, 100, 20, color(#989D75));
  floatingPlat6 = new Platform(600, 500, 100, 20, color(#989D75));
  floatingPlat7 = new Platform(500, 430, 100, 20, color(#989D75));
  floatingPlat8 = new Platform(400, 360, 100, 20, color(#989D75));
  floatingPlat9 = new Platform(300, 290, 100, 20, color(#989D75));
  floatingPlat10 = new Platform(800, 220, 700, 20, color(#989D75));
  floatingPlat11 = new Platform(260, 100, 20, 360, color(#989D75));

  // level three platforms
  plat10 = new Platform(150, height, 100, 100, color(#989D75));
  plat11 = new Platform(320, height, 100, 100, color(#989D75));
  plat12 = new Platform(480, height, 100, 200, color(#989D75));
  plat13 = new Platform(620, height, 100, 300, color(#989D75));
  plat14 = new Platform(760, height, 100, 400, color(#989D75));
  plat15 = new Platform(900, height, 100, 500, color(#989D75));

  // final level platforms
  plat16 = new Platform(150, height, 100, 100, color(#989D75));
  plat17 = new Platform(550, height, 500, 50, color(#989D75));
  plat18 = new Platform(950, height, 100, 100, color(#989D75));

  //initial platform list for level one
  platformList = new ArrayList<Platform>();
  platformList.add(plat1);
  platformList.add(plat2);
  platformList.add(plat3);
  platformList.add(plat4);
  platformList.add(floatingPlat1);
  platformList.add(floatingPlat2);
  platformList.add(floatingPlat3);
  platformList.add(floatingPlat4);
  platformList.add(floatingPlat12);
  platformList.add(floatingPlat13);
  platformList.add(floatingPlat14);
  platformList.add(floatingPlat15);
  platformList.add(floatingPlat16);
  platformList.add(floatingPlat17);

  // level one enemies
  e1 = new Enemy(300, (685 - plat3.h / 2), 30, 100, 25, color(255, 0, 0), 300);
  e2 = new Enemy(650, (685 - plat1.h / 2), 30, 100, 25, color(255, 0, 0), 650);
  e3 = new Enemy(1000, 685, 50, 150, 50, color(255, 0, 0), 1000);

  // level two enemies
  e4 = new Enemy(150, (685 - plat5.h / 2), 30, 100, 25, color(255, 0, 0), 150);
  e5 = new Enemy(275, (685 - plat6.h / 2), 30, 100, 25, color(255, 0, 0), 275);
  e6 = new Enemy(400, (685 - plat7.h / 2), 30, 100, 25, color(255, 0, 0), 400);
  e7 = new Enemy(550, (675 - plat8.h / 2), 50, 150, 50, color(255, 0, 0), 550);
  e8 = new Enemy(900, (670 - plat9.h / 2), 60, 200, 75, color(255, 0, 0), 900);
  e13 = new Enemy(800, (245 - plat10.h / 2), 30, 100, 25, color(255, 0, 0), 800);

  // level three enemies
  e9 = new Enemy(150, (675 - plat10.h / 2), 50, 150, 50, color(255, 0, 0), 150);
  e10 = new Enemy(480, (675 - plat12.h / 2), 50, 150, 50, color(255, 0, 0), 480);
  e11 = new Enemy(760, (675 - plat14.h / 2), 50, 150, 50, color(255, 0, 0), 760);
  e12 = new Enemy(1050, (height - 30), 60, 200, 75, color(255, 0, 0), 1050);

  // boss enemy for final level
  boss = new Enemy((width / 2), (665 - plat17.h / 2), 70, 500, 100, color(255, 0, 0), (width / 2));

  // tutorial refill example
  refillExample = new Health_Refill(860, 542, 20, 7, 7, 20, color(0, 255, 0));

  // level one refill
  refill1 = new Health_Refill(1000, 150, 20, 7, 7, 20, color(0, 255, 0));

  // level two refill
  refill2 = new Health_Refill(1000, 190, 20, 7, 7, 20, color(0, 255, 0));

  // final level refill
  refill3 = new Health_Refill(150, 600, 20, 7, 7, 20, color(0, 255, 0));

  //initial refill list for level one
  refillList = new ArrayList<Health_Refill>();
  refillList.add(refill1);

  // initial enemy list for level one
  enemyList = new ArrayList<Enemy>();
  enemyList.add(e3);
  enemyList.add(e2);
  enemyList.add(e1);

  /* a list of all the enemies in the entire game. used in the reset
   health method to reset all of the enemies health totals */
  fullEnemyList = new ArrayList<Enemy>();
  fullEnemyList.add(e3);
  fullEnemyList.add(e2);
  fullEnemyList.add(e1);
  fullEnemyList.add(e4);
  fullEnemyList.add(e5);
  fullEnemyList.add(e6);
  fullEnemyList.add(e7);
  fullEnemyList.add(e8);
  fullEnemyList.add(e9);
  fullEnemyList.add(e10);
  fullEnemyList.add(e11);
  fullEnemyList.add(e12);
  fullEnemyList.add(e13);
  fullEnemyList.add(boss);

  // buttons
  startButton = new Button(width / 2, height - 500, 200, 100, color(#2FD0EA));
  tutorialButton = new Button(width / 2, height - 300, 200, 100, color(#2FD0EA));
  backstoryButton = new Button(width / 2, height - 100, 200, 100, color(#2FD0EA));
  tutorialBackToMenuButton = new Button(200, 600, 200, 100, color(#2FD0EA));
  storyBackToMenuButton = new Button(550, 600, 200, 100, color(#2FD0EA));

  /* initializing my list of buttons */
  buttonList = new ArrayList<Button>();
  buttonList.add(startButton);
  buttonList.add(tutorialButton);
  buttonList.add(backstoryButton);

  /* initializing my image variables */
  // menu background
  menuBackground = loadImage("background.jpg");
  menuBackground.resize(menuBackground.width + 80, menuBackground.height);

  // level one background
  streetOne = loadImage("street_One.jpg");
  streetOne.resize(menuBackground.width + 80, streetOne.height);

  // level two background
  streetTwo = loadImage("street_Two.jpg");
  streetTwo.resize(menuBackground.width + 80, streetTwo.height);

  // level three background
  dunes = loadImage("dunes.jpg");
  dunes.resize(dunes.width + 80, dunes.height);

  // final level background
  palace = loadImage("palace.jpg");
  palace.resize(palace.width + 80, palace.height);
  
  // death screen background
  deathScreen = loadImage("deathScreen.png");
  deathScreen.resize(deathScreen.width, deathScreen.height);
  
  // game complete screen background
  gameCompleteScreen = loadImage("GameComplete.jpeg");
  gameCompleteScreen.resize(gameCompleteScreen.width, gameCompleteScreen.height);

  // initializing my sound files
  ambiance = new SoundFile(this, "ambiance.mp3");
  levelMusic = new SoundFile(this, "LevelMusic.mp3");
  bossMusic = new SoundFile(this, "BossMusic.mp3");
  grunt = new SoundFile(this, "grunt.wav");
  death = new SoundFile(this, "Death.wav");
  slice = new SoundFile(this, "Slice.wav");
  refill = new SoundFile(this, "Refill.wav");
  gameComplete = new SoundFile(this, "GameComplete.wav");
}

// draw
void draw() {
  background(42);
  currentTime = millis();
  stateMachine();
  ambiance();
  levelMusic.amp(0.5);
  levelMusic();
  refill.amp(5);
}

//////////////////////////////////
// FUNCTION DEFINITIONS
//////////////////////////////////

/* key pressed function to start the player movement features
 e.g. if the 'a' key is pressed, the player will begin to move left.
 also handles the state machine switches */
void keyPressed() {
  if (key == 'a') {
    assassin.isMovingLeft = true;
    assassin.isFacingLeft = true;
    assassin.isFacingRight = false;
    assassin.runLeftAnimation.isAnimating = true;
  }
  if (key == 'd') {
    assassin.isMovingRight = true;
    assassin.isFacingRight = true;
    assassin.isFacingLeft = false;
    assassin.runRightAnimation.isAnimating = true;
  }

  /* only allow the player to jump if they are not falling
   or are not already in the middle of a jump. if they are facing right
   then display the jumping right animation. if they are facing left then
   display the jumping left animation */
  if (key == 'w' && assassin.isJumping == false && assassin.isFalling == false && assassin.isFacingRight == true) {
    assassin.isJumping = true;
    assassin.maxJumpY = assassin.y - assassin.jumpHeight;
    assassin.jumpingRightAnimation.isAnimating = true;
  } else if (key == 'w' && assassin.isJumping == false && assassin.isFalling == false && assassin.isFacingLeft == true) {
    assassin.isJumping = true;
    assassin.maxJumpY = assassin.y - assassin.jumpHeight;
    assassin.jumpingLeftAnimation.isAnimating = true;
  }

  /* on the screens shown after a level is complete,
   you can use the space bar to move on to the next level */
  if (key == ' ' && state == 2) {
    state = 3;
  } else if (key == ' ' && state == 4) {
    state = 5;
  } else if (key == ' ' && state == 6) {
    state = 7;
  }

  /* if you complete the game then you can press space to go back to the
   start screen. If you do this, then the game completely resets to its original
   state so that it can be started over properly */
  if (state == 8 && key == ' ') {
    state = 0;
  }

  /* if the player dies then you are taken to the
   death screen and can press the space bar to be taken back
   to the main menu and restart the game */
  if (state == 9 && key == ' ') {
    state = 0;
    assassin.isDead = false;
    resetGame();
  }
}

/* key released function to stop the player movement features
 e.g. if the 'a' is released, the player will stop moving left */
void keyReleased() {
  if (key == 'a') {
    assassin.isMovingLeft = false;
    assassin.runLeftAnimation.isAnimating = false;
  }
  if (key == 'd') {
    assassin.isMovingRight = false;
    assassin.runRightAnimation.isAnimating = false;
  }
  if (key == 'w') {
    assassin.isJumping = false;
    assassin.jumpingRightAnimation.isAnimating = false;
  }
}

/* mouse pressed function */
void mousePressed() {
  /* changes the state of the program based on which
   button is pressed on the start screen */
  if (startButton.isColliding == true) {
    resetGame();
    state = 1;
    startButton.isColliding = false;
  } else if (tutorialButton.isColliding == true) {
    state = 10;
    tutorialButton.isColliding = false;
  } else if (backstoryButton.isColliding == true) {
    state = 11;
    backstoryButton.isColliding = false;
  } else if (tutorialBackToMenuButton.isColliding == true) {
    state = 0;
    tutorialBackToMenuButton.isColliding = false;
  } else if (storyBackToMenuButton.isColliding == true) {
    state = 0;
    storyBackToMenuButton.isColliding = false;
  }

  /* allows the player to click the mouse and attack
   an enemy once they are inside of that enemies attack box */
  for (Enemy anEnemy : enemyList) {
    if (anEnemy.isCollidingWithPlayerAttackBox == true) {
      anEnemy.health -= assassin.damage;
      assassin.isAttacking = true;
    } else assassin.isAttacking = false;
  }
}

/* toggles the players attack ability to off when
 the attack button (mouse) is released */
void mouseReleased() {
  assassin.isAttacking = false;
}

/* takes the list of enemies and applies all of the
 enemy functions to every enemy in the list */
void handleEnemies() {
  for (Enemy anEnemy : enemyList) {
    anEnemy.render();
    anEnemy.renderHealthBar();
    anEnemy.isCollidingWithPlayerAttack(assassin);
    anEnemy.updateHealthBar();
    anEnemy.oscillateVariables();
    anEnemy.move();
    anEnemy.attackAnimation();
  }
}

/* takes the list of level one platforms and
 handles all of the functions that apply to them */
void handlePlatforms() {
  for (Platform aPlatform : platformList) {
    aPlatform.render();
    aPlatform.collideWithPlayer(assassin);
  }
}

/* condenses all of the player functions into one function.
 handles all of the player features/functions */
void handlePlayer() {
  assassin.render();
  assassin.renderHealth();
  assassin.move();
  assassin.jump();
  assassin.topOfJump();
  assassin.fall();
  assassin.land();
  assassin.fallOffPlatform(platformList);
  assassin.restrictMovement(enemyList);
  playerCollidingWithEnemyAttack();
  playerCollidingWithHealthRefill();
  enemiesAttacking();
  assassin.playerDeath();
  assassin.hasBeenRefilled();
  assassin.attackAnimationBoolean();
  assassin.animateAttack();
}

/* handles all of the health refill functions */
void handleHealthRefills() {
  for (Health_Refill aRefill : refillList) {
    aRefill.render();
  }
}

/* handles all of the button functions */
void handleButtons() {
  for (Button aButton : buttonList) {
    aButton.render();
    aButton.isColliding();
  }
}

/* removes enemies who have been killed from the game */
void removeEnemies() {
  for (int i = enemyList.size() - 1; i >= 0; i -= 1) {
    Enemy anEnemy = enemyList.get(i);

    if (anEnemy.health <= 0) {
      enemyList.remove(anEnemy);
    }
  }
}

/* removes a health refill if it has been collected */
void removeRefills() {
  for (int i = refillList.size() - 1; i >= 0; i -= 1) {
    Health_Refill aRefill = refillList.get(i);

    if (assassin.collidingWithRefillHitBox == true) {
      refillList.remove(aRefill);
      assassin.collidingWithRefillHitBox = false;
    }
  }
}

/* resets all of the enemies healths based off
 of their respective sizes */
void resetEnemyHealth() {
  for (Enemy anEnemy : fullEnemyList) {
    anEnemy.health = anEnemy.health;

    if (anEnemy.size == 30) {
      anEnemy.health = 100;
    }
    if (anEnemy.size == 50) {
      anEnemy.health = 150;
    }
    if (anEnemy.size == 60) {
      anEnemy.health = 200;
    }
    if (anEnemy.size == 70) {
      anEnemy.health = 500;
    }
  }
}

/* resets the players health when the game
 is reset */
void resetPlayerHealth() {
  assassin.health = 300;
}

/* resests the final levels left platform height
 so that when the game is restarted without closing
 the application, the final level is returned to its original
 state */
void resetPlatformHeight() {
  plat16.h = 100;
}

/* resets the hitboxes for the left platform within the final
 level so that it is reset back to its original state. Used once
 the game has been restarted */
void resetPlatformHitbox() {
  plat16.top = plat16.y - (plat16.h/ 2);
  plat16.left = plat16.x - (plat16.w / 2);
  plat16.right = plat16.x + (plat16.w / 2);
  plat16.bottom = plat16.y + plat16.h / 2;
}

/* resets all of the enemies health bars once
 the game is restarted */
void resetEnemiesHealthBar() {
  for (Enemy anEnemy : fullEnemyList) {
    anEnemy.healthBarAmt = anEnemy.size;
  }
}

/* adds all of the level one platforms to the platform list.
 used when the game is reset either after dying, or after completing
 the game and restarting without closing the application */
void addLevelOnePlatforms() {
  platformList.clear();
  platformList.add(plat1);
  platformList.add(plat2);
  platformList.add(plat3);
  platformList.add(plat4);
  platformList.add(floatingPlat1);
  platformList.add(floatingPlat2);
  platformList.add(floatingPlat3);
  platformList.add(floatingPlat4);
  platformList.add(floatingPlat12);
  platformList.add(floatingPlat13);
  platformList.add(floatingPlat14);
  platformList.add(floatingPlat15);
  platformList.add(floatingPlat16);
  platformList.add(floatingPlat17);
}

/* adds all of the level one enemies to the enemy list.
 used when the game is reset either after dying, or after completing
 the game and restarting without closing the application */
void addLevelOneEnemies() {
  enemyList.clear();
  enemyList.add(e3);
  enemyList.add(e2);
  enemyList.add(e1);
}

/* adds the level one refill to the refill list.
 used when the game resets */
void addLevelOneRefill() {
  refillList.clear();
  refillList.add(refill1);
}

/* resets the game to its original state */
void resetGame() {
  /* re-adding the level one platforms so that they
   reset whenever the game is reset */
  addLevelOnePlatforms();

  /* re-adding the level one enemies so that they reset
   whenever the game is reset */
  addLevelOneEnemies();

  /* adds the level one refill to
   the list */
  addLevelOneRefill();

  /* resetting all of the enemies health and health bars back to
   their original state */
  resetEnemyHealth();
  resetEnemiesHealthBar();

  /* resetting the final levels platform
   so that it is back to its orignal state
   along with resetting the platforms hit boxes */
  resetPlatformHeight();
  resetPlatformHitbox();

  /* resetting the players health */
  resetPlayerHealth();

  /* reset the players position back to the start */
  assassin.x = 50;
  assassin.y = 650;
}

/* increases the height of the platforms once the player
 crosses a certain x value. Only used within the boss level */
void heightIncrease(Player aPlayer) {
  if (aPlayer.x > (plat16.x + plat16.w / 2 + 20) && plat16.h <= 1400 && plat18.h <= 1400) {
    plat16.h += 20;
    plat18.h += 20;

    /* increases the values of the platform hitboxes
     to match the platforms height increase, so that
     the player cannot jump through the increased platforms */
    plat16.top = plat16.y - (plat16.h/ 2);
    plat16.left = plat16.x - (plat16.w / 2);
    plat16.right = plat16.x + (plat16.w / 2);
    plat16.bottom = plat16.y + plat16.h / 2;

    plat18.top = plat18.y - (plat18.h/ 2);
    plat18.left = plat18.x - (plat18.w / 2);
    plat18.right = plat18.x + (plat18.w / 2);
    plat18.bottom = plat18.y + plat18.h / 2;
  }
}

/* once the boss is defeated, the right most platform
 deacreses in height to allows the player to "escape" and
 complete the game */
void heightDecrease() {
  if (enemyList.isEmpty() == true && plat18.h >= 100) {
    plat18.h -= 20;

    plat18.top = plat18.y - (plat18.h/ 2);
    plat18.left = plat18.x - (plat18.w / 2);
    plat18.right = plat18.x + (plat18.w / 2);
    plat18.bottom = plat18.y + plat18.h / 2;
  }
}

/* loops through the entire enemy list and
 checks to see if the player is colliding with an
 enemies attack hitbox */
void playerCollidingWithEnemyAttack() {
  for (Enemy anEnemy : enemyList) {
    assassin.isCollidingWithEnemyAttack(anEnemy);
  }
}

/* loops throught the entire list of health refills
 and checks to see if the player is colliding with a refills
 hit box */
void playerCollidingWithHealthRefill() {
  for (Health_Refill aRefill : refillList) {
    assassin.isCollidingWithHealthRefill(aRefill);
  }
}

/* loops through the list of enemies and determines
 if an enemy has attacked the player */
void enemiesAttacking() {
  for  (Enemy anEnemy : enemyList) {
    assassin.hasBeenAttacked(anEnemy);
  }
}

/* if the player dies then show
 the player death screen */
void playerDied() {
  if (assassin.isDead == true) {
    state = 9;

    /* playing the death sound */
    if (death.isPlaying() == false) {
      death.playFor(1);
    }
  }
}

/* playing the ambiance sound file */
void ambiance() {
  if (state == 0 || state == 2 || state == 4 || state == 6) {
    if (ambiance.isPlaying() == false) {
      ambiance.play();
    }
  }
}

/* playing the level music sound file if the player is playing a level */
void levelMusic() {
  if (state == 1 || state == 3 || state == 5) {
    if (levelMusic.isPlaying() == false) {
      levelMusic.play();
    }
  }
}

/* represents the first state of the game, the start screen */
void startScreen() {
  background(42);
  gameComplete.stop();

  /* displaying the background image */
  image(menuBackground, width / 2, height / 2);

  /* handle all of the buttons */
  handleButtons();

  /* displaying all of the text for this screen */
  fill(#2FD0EA);
  rect(width / 2, 75, 800, 100, 5);
  fill(0);
  textSize(100);
  text("Assassin's Revenge", width / 7, 100);
  textSize(35);
  fill(0);
  text("Start Game", width - 630, height - 500);
  text("Tutorial", width - 610, height - 300);
  text("Story", width - 590, height - 100);
}

/* represents the first level of the game */
void levelOne() {
  ambiance.stop();

  /* loading in the background image */
  image(streetOne, width / 2, height / 2);

  /* handles all the level one enemies */
  handleEnemies();
  removeEnemies();

  /* handles all of the level one platforms */
  handlePlatforms();

  /* handles all of the player features
   including the player death */
  handlePlayer();
  playerDied();

  /* handles all of the health refill functions
   including the removal of them */
  handleHealthRefills();
  removeRefills();

  /* handles the level switch condition */
  switchLevel();
}

/* represents the screen shown after you complete
 level one */
void levelOneComplete() {
  levelMusic.stop();
  background(#E8E5A9);
  fill(0);
  textSize(100);
  text("Level One Complete", width / 8, 100);
  textSize(50);
  text("Press 'space' to continue", width / 4, 300);
}

/* represents the second level of the game */
void levelTwo() {
  background(42);
  ambiance.stop();

  /* loading in the background image */
  image(streetTwo, width / 2, height / 2);

  /* handles all of the level two platforms */
  handlePlatforms();

  /* handles all of the level two enemies
   and handles the removal of those enemies */
  handleEnemies();
  removeEnemies();

  /* handles the level switch condition */
  switchLevel();

  /* handles all of the health refill functions
   including the removal of them */
  handleHealthRefills();
  removeRefills();

  /* handles all of the player features including
   player death */
  handlePlayer();
  playerDied();
}

/* represents the screen shown after you
 complete level two */
void levelTwoComplete() {
  levelMusic.stop();
  background(#E8E5A9);
  fill(0);
  textSize(100);
  text("Level Two Complete", width / 8, 100);
  textSize(50);
  text("Press 'space' to continue", width / 4, 300);
}

/* represents the third level of the game */
void levelThree() {
  background(42);
  ambiance.stop();

  /* displaying the background image */
  image(dunes, width / 2, height / 2);

  /* handles all of the level three platforms */
  handlePlatforms();

  /* handles all of the new enemies and
   handles the removal of them */
  handleEnemies();
  removeEnemies();

  /* handles all of the player features including
   player death */
  handlePlayer();
  playerDied();

  /* handles all of the health refill functions
   including the removal of them */
  handleHealthRefills();
  removeRefills();

  /* handles the level switch condition */
  switchLevel();

  /* resets the players position back to the
   start if the player falls from on one of
   taller platforms */
  assassin.resetPosition();
}

/* represents the screen show after you complete level three */
void levelThreeComplete() {
  levelMusic.stop();
  background(#E8E5A9);
  fill(0);
  textSize(100);
  text("Level Three Complete", width / 9, 100);
  textSize(50);
  text("The King Awaits...", width / 3, 200);
  text("Press 'space' to continue", width / 4, 300);
}

/* represents the final level of the game */
void finalLevel() {
  ambiance.stop();

  /* playing the boss level music */
  if (bossMusic.isPlaying() == false) {
    bossMusic.play();
  }

  /* loading in the background image */
  image(palace, width / 2, height / 2);

  /* handles all of the final level platforms */
  handlePlatforms();

  /* increases the height of the two side platforms within
   this level so that the barriers trap the player
   with the boss enemy */
  heightIncrease(assassin);

  /* decreases the height of the right most platform
   once the player has defeated the boss */
  heightDecrease();

  /* handles the boss enemy and
   handles the removal of the boss */
  handleEnemies();
  removeEnemies();

  /* handles all of the health refill functions
   including the removal of them */
  handleHealthRefills();
  removeRefills();

  /* handles all of the player features including
   player death */
  handlePlayer();
  playerDied();

  /* handles the level switch condition */
  switchLevel();
}

/* displays the screen shown whenever you complete
 the final game */
void gameComplete() {
  bossMusic.stop();
  
  /* play the game complete music */
  if (gameComplete.isPlaying() == false) {
    gameComplete.play();
  }

  image(gameCompleteScreen, width / 2, height / 2);
  fill(0);
  textSize(100);
  text("Game Completed", width / 6, 100);
  textSize(50);
  text("Press 'space' to return to the menu", width / 6, 300);
}

/* displays the screen shown whenever the player dies */
void playerDeathScreen() {
  levelMusic.stop();
  bossMusic.stop();
  
  image(deathScreen, width / 2, height / 2);
  fill(0);
  textSize(100);
  text("You Died", width / 3, 100);
  textSize(50);
  text("Press 'space' to return to the menu", width / 6, 300);
}

/* displays the tutorial screen */
void tutorialScreen() {
  background(#E8E5A9);

  /* rendering a health refill to act as an example when looking at the tutorial screen */
  refillExample.render();

  /* rendering and handling the back to menu button */
  tutorialBackToMenuButton.render();
  tutorialBackToMenuButton.isColliding();

  /* displaying all of the text on the tutorial screen */
  fill(0);
  textSize(100);
  text("Tutorial", width / 3, 100);
  textSize(50);
  text("Controls: ", 50, 200);
  text("Important Tips: ", 50, 450);
  textSize(25);
  text("Use 'A' && 'D' to move left and right.", 275, 200);
  text("Use 'W' to jump.", 275, 250);
  text("Click the mouse to attack.", 275, 300);
  text("Your health is displayed at the top of the screen.", 400, 450);
  text("The enemies health bars are displayed above each enemy.", 400, 500);
  text("Be on the lookout for green health refills! - ", 400, 550);
  text("You will usually need to go up to collect them.", 400, 600);
  textSize(30);
  text("Back to Menu", 118, 600);
}

/* displays the story screen */
void backstoryScreen() {
  background(#E8E5A9);

  /* rendering and handling the back to menu button */
  storyBackToMenuButton.render();
  storyBackToMenuButton.isColliding();

  /* displaying all of the text on this screen */
  fill(0);
  textSize(100);
  text("Assassins's Story", width / 6, 100);
  textSize(30);
  text("Back to Menu", 468, 600);
  textSize(25);
  text("Set in 1150 AD, you control the master assassin Ezio Auditore da Firenze. Not much is known about", 40, 200 );
  text("Ezio except that he is extremely deadly. He has been highly trained in the ways of the order of assassins,", 10, 250);
  text("a sofisticated order of assassins that brings justice to order by ridding of any and all corruption.", 10, 300);
  text("Corruption is deep in the city of Baghdad, the king has his hand in almost every sector of the city, and", 10, 350);
  text("the king makes sure that the lower social class is exploited as much as possible. Ezio, who's wife was", 10, 400);
  text("killed by the hands of the king years ago, sets out to get revenge not only for the citizens of Baghdad,", 10, 450);
  text("but also for his long lost wife. Take control of Ezio and make sure his revenge is earned.", 10, 500);
}

/* switches to the next level once the player reaches the opposite side of the screen
 and all of the enemies within the level have been destroyed.
 resets the players position back to the left of the screen */
void switchLevel() {
  if (assassin.x >= width && assassin.y > 500 && enemyList.isEmpty()) {
    state += 1;
    assassin.x = 50;
  }

  /* if level two becomes active then load in all
   of the level two enemies and platforms */
  if (state == 2) {
    /* clearing the enemy list and
     adding the level two enemies to the list */
    enemyList.clear();
    enemyList.add(e13);
    enemyList.add(e8);
    enemyList.add(e7);
    enemyList.add(e6);
    enemyList.add(e5);
    enemyList.add(e4);

    /* clears the original platforms from
     the first level and adds the new ones for the second level */
    platformList.clear();
    platformList.add(plat5);
    platformList.add(plat6);
    platformList.add(plat7);
    platformList.add(plat8);
    platformList.add(plat9);
    platformList.add(plat19);
    platformList.add(floatingPlat11);
    platformList.add(floatingPlat5);
    platformList.add(floatingPlat6);
    platformList.add(floatingPlat7);
    platformList.add(floatingPlat8);
    platformList.add(floatingPlat9);
    platformList.add(floatingPlat10);

    /* clear the level one refill and add the level two refill */
    refillList.clear();
    refillList.add(refill2);
  }

  /* if level three becomes active then load in all
   of the level three enemies and platforms */
  if (state == 4) {
    /* clears the platform list and adds the
     level three platforms to the list */
    platformList.clear();
    platformList.add(plat10);
    platformList.add(plat11);
    platformList.add(plat12);
    platformList.add(plat13);
    platformList.add(plat14);
    platformList.add(plat15);

    /* clears the list of enemies and adds in
     the new level three enemies */
    enemyList.clear();
    enemyList.add(e12);
    enemyList.add(e11);
    enemyList.add(e10);
    enemyList.add(e9);
  }

  /* if the final becomes active then load in all
   of the final level enemies and platforms */
  if (state == 6) {
    /* clears the platform list and adds the
     boss level platforms to the list */
    platformList.clear();
    platformList.add(plat16);
    platformList.add(plat17);
    platformList.add(plat18);

    /* clears the list of enemies and adds in
     the new boss enemy */
    enemyList.clear();
    enemyList.add(boss);

    /* clear the level two refill and add the final level refill */
    refillList.clear();
    refillList.add(refill3);
  }
}

/* state machine that handles the different states of the game */
void stateMachine() {
  switch(state) {
  case 0:
    startScreen();
    break;

  case 1:
    levelOne();
    break;

  case 2:
    levelOneComplete();
    break;

  case 3:
    levelTwo();
    break;

  case 4:
    levelTwoComplete();
    break;

  case 5:
    levelThree();
    break;

  case 6:
    levelThreeComplete();
    break;

  case 7:
    finalLevel();
    break;

  case 8:
    gameComplete();
    break;

  case 9:
    playerDeathScreen();
    break;

  case 10:
    tutorialScreen();
    break;

  case 11:
    backstoryScreen();
    break;
  }
}

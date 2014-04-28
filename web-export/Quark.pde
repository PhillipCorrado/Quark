import ddf.minim.*;
Minim minim;

AudioManager audio;
StartUpScreen screen;
Player player;
Level level;
LevelManager levelManager;
Countdown timer;
ScoreHiScore score;

void setup() {
  size(500, 500);
  textAlign(CENTER);
  frameRate(60);
  minim = new Minim(this);
  audio = new AudioManager();
  screen = new StartUpScreen();
  level = new Level();
  levelManager = new LevelManager();
  player = new Player();
  timer = new Countdown();
  score = new ScoreHiScore();
  audio.playerA.loop();
}

void draw() {
  screen.display();
}

void keyPressed() {
  player.detectKeyPressed();
}

void keyReleased() {
  player.detectKeyReleased();
}
class AudioManager {
  AudioPlayer playerA;
  AudioSample up;
  AudioSample down;
  AudioSample left;
  AudioSample right;
  AudioSample success;

  AudioManager() {
    playerA = minim.loadFile("MazeGameBGM.wav");
    up = minim.loadSample("MazeGameUp.wav", 512);
    down = minim.loadSample("MazeGameDown.wav", 512);
    left = minim.loadSample("MazeGameLeft.wav", 512);
    right = minim.loadSample("MazeGameRight.wav", 512);
    success = minim.loadSample("MazeGameSuccess.wav", 512);
  }
}

class Blocker {
  int x, y, size, k;
  color c = color(random(255));
  int playerConfused = 0;
  color purple = color(142, 44, 156);

  Blocker() {
    randomize();
  }

  void randomize() {
    x = (int)(random(width));
    y = (int)(random(height));
    size = (int)(random(20, 240));
    c = color(random(255));
  }
  
  void collision() {
    k = 0;
    if(dist(x, y, player.x, player.y) < (size/2 + player.size/2)) {
      while(k < 1) {
        player.speed *= -1;
        timer.interval -= 5;
        playerConfused++;
        playerState();
        k++;
      } 
    }
    if(dist(x, y, player.x, player.y) > (size/2 + player.size/2) && k >= 1) {
      player.speed *= -1;
      k = 0;
    }
  }
  
  void playerState() {
    if((playerConfused % 2) == 0) {
      player.c = color(255, 255, 255);
    }
    else if((playerConfused % 2) == 1) {
      player.c = color(purple);
    }
  }
  
  void exitOverlap() {
    if(dist(x, y, levelManager.exit.x, levelManager.exit.y) < ((size/2+5) + (levelManager.exit.size/2+5))) {
      randomize();
    }
  }
  
  void playerOverlap() {
    if(dist(x, y, player.x, player.y) < (size/2 + player.size/2)) {
      randomize();
      k = 1;
    }
  }


  void display() {
    strokeWeight(1);
    noStroke();
    fill(c);
    ellipse(x, y, size, size);
    collision();
    exitOverlap();
    playerOverlap();
  }
}

class Exit {

  int x, y;
  int size = 50;
  color c = color(255);

  Exit () {
    randomize();
  }

  void randomize() {
    x = (int)(random(size, width-size));
    y = (int)(random(size, height-size));
  }

  void display() {
    strokeWeight(5);
    stroke(c);
    noFill();
    ellipse(x, y, size, size);

    if (dist(player.x, player.y, x, y) <= 10) {
      levelManager.advanceLevel();
      timer.interval+=2;
      audio.success.trigger();
    }
  }
}

PFont font;

class Countdown {

  String time = "010";
  int t;
  int interval = 30;
  boolean timeGood;
  boolean timeNeutral;
  boolean timeBad;
  boolean gameOver;

  Countdown() {
    font = createFont("Bauhaus 93", 60);
    textFont(font);
  }

  void display() {
    fill(255);
    t = interval-int(millis()/1000);
    time = nf(t, 3);
    
    if(t > 30) {
      timeGood = true;
      timeNeutral = false;
      timeBad = false;
    }
    else if(t < 30 && t > 15) {
      timeGood = false;
      timeNeutral = true;
      timeBad = false;
    }
    else if(t < 15 && t > 0) {
      timeGood = false;
      timeNeutral = false;
      timeBad = true;
      gameOver = false;
    }
    else if(t <= 0) {
      timeGood = false;
      timeNeutral = false;
      timeBad = true;
      gameOver = true;
      gameOver();
    }

    text(time, width/2, height/2+textAscent()/3);
  }
  
  void update() {
    if(t > 30) {
      timeGood = true;
      timeNeutral = false;
      timeBad = false;
      gameOver = false;
    }
    else if(t < 30 && t > 15) {
      timeGood = false;
      timeNeutral = true;
      timeBad = false;
      gameOver = false;
    }
    else if(t < 15 && t > 0) {
      timeGood = false;
      timeNeutral = false;
      timeBad = true;
      gameOver = false;
    }
    else if(t <= 0) {
      timeGood = false;
      timeNeutral = false;
      timeBad = true;
      gameOver = true;
      gameOver();
    }
  }
  
  void reset() {
    if(player.resetGame == true) {
      interval = 30 + int(millis()/1000);
      player.speed = 5;
      time = nf(t, 3);
      levelManager.resetLevel();
    }
  }
  
  void gameOver() {
    if(gameOver == true) {
      player.speed *= 0;
      time = "GAME OVER";
      audio.up.stop();
      audio.down.stop();
      audio.left.stop();
      audio.right.stop();
      text("Press [R] to Retry", width/2, (height-height/4)+textAscent()/3);
      text("Press [T] to Return to the Title Screen", width/2, (height-height/6)+textAscent()/3);
      player.sUse = true;
      screen.escape();
    }  
  }
}

class Level {
  color cGood;
  color cNeutral;
  color cBad;
  
  Level() {
    cGood = color(random(128), random(128), 255);
    cNeutral = color(random(128), 255, random(128));
    cBad = color(255, random(128), random(128));
  }
  
  void display() {
    if(timer.timeGood == true) {
      noStroke();
      fill(cGood);
      rect(0,0,width,height);
    }
    else if(timer.timeBad == true) {
      noStroke();
      fill(cBad);
      rect(0,0,width,height);
    }
    else if(timer.timeNeutral == true) {
      noStroke();
      fill(cNeutral);
      rect(0,0,width,height);
    }
  }
  
  void update() {
    if(timer.timeGood == true) {
      noStroke();
      cGood = color(random(128), random(128), 255);
      fill(cGood);
      rect(0,0,width,height);
    }
    else if(timer.timeBad == true) {
      noStroke();
      cBad = color(255, random(128), random(128));
      fill(cBad);
      rect(0,0,width,height);
    }
    else if(timer.timeNeutral == true) {
      noStroke();
      cNeutral = color(random(128), 255, random(128));
      fill(cNeutral);
      rect(0,0,width,height);
    }
  }
}
class LevelManager {
  Level levels;
  int numOfBlockers = 5;
  int count = 0;
  Blocker[] blockers;
  Exit exit;

  LevelManager() {
    levels = new Level(); 
    
    blockers = new Blocker[numOfBlockers];
    for (int i = 0; i < blockers.length; i++) {
      blockers[i] = new Blocker();
    }
    exit = new Exit();
  }

  void levelCollision() {
    for (int i = 0; i < blockers.length; i++) {
      float dist = dist(player.x, player.y, blockers[i].x, blockers[i].y);
      if (dist < (player.size/2 + blockers[i].size/2)) {
        // you are walking on a blocker
      }
    }
  }

  void display() {
    levels.display();
    for (int i = 0; i < blockers.length; i++) {
      blockers[i].display();
    }
    exit.display();
  }
  
  void advanceLevel() {
    for (int i = 0; i < blockers.length; i++) {
      blockers[i].randomize();
      blockers[i].exitOverlap();
      blockers[i].playerOverlap();
    }
    levels.update();
    exit.randomize();
    count++;
  }
  
  void resetLevel() {
    
    count = 0;
    for (int i = 0; i < blockers.length; i++) {
      blockers[i].randomize();
      blockers[i].exitOverlap();
      blockers[i].playerOverlap();
    }
    levels.update();
    exit.randomize();
  }
}

class Player {

  int x, y, size, speed, audioStagger;
  boolean up, down, left, right, resetGame, gameStart, infoScreen, reTurn, sUse, rUse;
  color c = color(255, 255, 255);

  Player() {
    x = 100;
    y = 250;
    size = 50;
    speed = 5;
    audioStagger = 5;
  }

  void moveUp() {
    y -= speed;
    if (frameCount % audioStagger == 0) {
      audio.up.trigger();
    }
  }

  void moveDown() {
    y += speed;
    if (frameCount % audioStagger == 0) {
      audio.down.trigger();
    }
  }

  void moveLeft() {
    x -= speed;
    if (frameCount % audioStagger == 0) {
      audio.left.trigger();
    }
  }

  void moveRight() {
    x += speed;
    if (frameCount % audioStagger == 0) {
      audio.right.trigger();
    }
  }

  void wallConstrain() {
    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }

  void display() {
    if (up) { 
      moveUp();
    }
    if (down) { 
      moveDown();
    }
    if (left) { 
      moveLeft();
    }
    if (right) { 
      moveRight();
    }
    wallConstrain();
    noStroke();
    fill(c);
    ellipse(x, y, size, size);
  }

  void detectKeyPressed() {
    if (keyCode == UP) {
      up = true;
    }
    else if (keyCode == DOWN) {
      down = true;
    }
    else if (keyCode == LEFT) {
      left = true;
    }
    else if (keyCode == RIGHT) {
      right = true;
    }
    else if(keyCode == 'R') {
      resetGame = true;
      player.c = color(255, 255, 255);
    }
    else if(keyCode == 'S') {
      gameStart = true;
      if(sUse == true) {
        timer.interval = 30 + int(millis()/1000);
        speed = 5;
        levelManager.count = 0;
        player.c = color(255, 255, 255);
      }
      if(gameStart == true) {
        sUse = false;
      }
    }
    else if(keyCode == 'I') {
      infoScreen = true;
    }
    else if(keyCode == 'T') {
      reTurn = true;
    }
  }

  void detectKeyReleased() {
    if (keyCode == UP) {
      up = false;
    }
    else if (keyCode == DOWN) {
      down = false;
    }
    else if (keyCode == LEFT) {
      left = false;
    }
    else if (keyCode == RIGHT) {
      right = false;
    }
    else if(keyCode == 'R') {
      resetGame = false;
    }
    audio.up.stop();
    audio.down.stop();
    audio.left.stop();
    audio.right.stop();
  }
}

PFont counter;

class ScoreHiScore {
  
  String score = "000";
  String hiScore = "010";
  int highScore = 10;
  
  ScoreHiScore() {
    counter = createFont("Bauhaus 93", 30);
    textFont(counter);
  }
  
  void display() {
    fill(255);
    score = nf(levelManager.count, 3);
    if(levelManager.count >= highScore) {
      highScore = levelManager.count;
    }
    hiScore = nf(highScore, 3);
    text("[Score: " + score + "]", width/6, height/22+textAscent()/3);
    text("[Hi-Score: " + hiScore + "]", width/4.9, (height-height/22)+textAscent()/3);
  }
}
class StartUpScreen {
  
  color c;
  
  StartUpScreen() {
    counter = createFont("Arial", 30);
    textFont(counter);
    c = color(random(125), random(125), 255);
  }
  
  void backGround() {
    frameRate = 1;
    noStroke();
    fill(c);
    rect(0,0,width,height);
    noStroke();
    c = color(random(125), random(125), 255);
    fill(c);
    rect(random(width),random(height),width,height);
    c = color(random(125), random(125), 255);
    fill(c);
    rect(random(-width),random(-height),width,height);
  }
  
  void titleText() {
    fill(255);
    text("Quark", width/2, height/3+textAscent()/3);
    text("Press [S] to Start", width/2, (height-height/3)+textAscent()/3);
    text("Press [I] for More Information", width/2, (height-height/4)+textAscent()/3);
  }
  
  void display() {
    backGround();
    titleText();
    begin();
    information();
  }
  
  void update() {
    backGround();
    titleText();
    player.gameStart = false;
    player.infoScreen = false;
    player.reTurn = false;
  }
  
  void begin() {
    if(player.gameStart == true) {
      levelManager.display();
      player.display();
      timer.display();
      timer.reset();
      score.display();
    }
  }
  
  void infoText() {
    fill(255);
    text("Controls with the [Arrow Keys]", width/2, height/5.5+textAscent()/3);
    text("Reach the Goal, Avoid the Obstacles", width/2, height/3.5+textAscent()/3);
    text("Obstacles reverse Controls", width/2, height/2.5+textAscent()/3);
    text("The game ends if the Timer hits 0", width/2, height/2+textAscent()/3);
    text("Reaching the Goal     +2 Seconds", width/2, (height - height/2.5)+textAscent()/3);
    text("Hitting an obstacle      -5 Seconds", width/2, (height - height/3.5)+textAscent()/3);
    text("Press [T] to return to the Title Screen", width/2, (height-height/7)+textAscent()/3);
  }
  
  void information() {
    if(player.infoScreen == true) {
      backGround();
      infoText();
      escape();
    }
  }
  
  void escape() {
    if(player.reTurn == true) {
      update();
      player.gameStart = false;
      player.infoScreen = false;
    }
  }
}


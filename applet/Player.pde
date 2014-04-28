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


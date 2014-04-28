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


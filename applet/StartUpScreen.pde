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

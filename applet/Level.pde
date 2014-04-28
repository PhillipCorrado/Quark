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

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


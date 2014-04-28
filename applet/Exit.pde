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


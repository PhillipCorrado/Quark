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

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

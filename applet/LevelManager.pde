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


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


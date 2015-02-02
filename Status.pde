class Status{
  float shieldDuration = 300, notifyTime, iconWidth, iconHeight, gameState = 2, start, score, last, bonus;
  String notifyText;
  boolean shieldStatus;
  //Minim minim;
  AudioPlayer introSong;
  AudioPlayer backgroundSong;
  AudioPlayer gameOverSound;
  //0 for game over, 1 for running, 2 for paused
  
  Status(float iconWidth, float iconHeight){
    this.iconWidth = iconWidth;
    this.iconHeight = iconHeight;
    
    introSong = minim.loadFile("1. Intro Music.mp3");
    backgroundSong = minim.loadFile("2. Background Music.mp3");
    gameOverSound = minim.loadFile("9. Game Over.wav");
  }
  
  void addBonus(){
    bonus += 5;
  }
  
  float getState(){
    return gameState;
  }
  
  void setState(float state){
    gameState = state;
  }
  
  float getScore(){
    score = (millis()/1000 - start) + bonus;
    return score;
  }
  
  float getLastScore(){
    last = score;
    return last;
  }
  
  void reset(){
    start = millis()/1000;
    gameState = 1;
    bonus = 0;
    shieldDuration = 180;
  }
  
  float getShieldDuration(){
    return shieldDuration;
  }
  
  void setShieldDuration(float i){
    shieldDuration = i;
  }
  
  boolean getShieldStatus(){
    return shieldStatus;
  }
  
  void setShieldStatus(boolean shield){
    shieldStatus = shield;
  }
  
  void drawText(String s, float x, float y, int size) {
    //Text output method
    textAlign(CENTER);
    textSize(size);
    text(s, x, y); 
  }
 
  void setNotifyText(String s, float i){
    notifyText = s;
    notifyTime = i;
  }
  
  void display(){
    String shieldDuration = nfs(getShieldDuration()/60, 1, 1);
    drawText("Shield: " + shieldDuration, width - 155, 35, 12);
    
    switch((int)gameState){
      case 0:
        backgroundSong.pause();
        backgroundSong.rewind();
        
        drawText("Score: " + (int)getLastScore(), width - 55, 35, 12);
        drawText("Game Over. Press 'r' to restart.", width/2, height/2, 20);
        break;
      case 1:
        introSong.pause();
        introSong.rewind();
        gameOverSound.rewind();
        backgroundSong.play();
        
        drawText("Score: " + (int)getScore(), width - 55, 35, 12);
        
        if ((getShieldDuration() > 0) && (getShieldStatus() == true)){
          setShieldDuration(getShieldDuration()-1);
        }
    
        if (getShieldDuration() == 0 && getShieldStatus() == true){
          setShieldStatus(false);
          setNotifyText("Shield depleted - deactivating.", 120);
        }
        
        break;
      case 2:
        drawText("Press SPACE to start", width/2, height/2, 20);
        drawText("Score: " + (int)getLastScore(), width - 55, 35, 12);
        introSong.play();
        break;
    }
    
    if (notifyTime > 0){
      drawText(notifyText, width/2, (height/2) - 200, 16);
      notifyTime--;
    }
  }
}

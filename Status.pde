class Status{
  //0 = game over, 1 = game running, 2 = paused
  int gameState = 2, iconWidth = 50, iconHeight = 50, notifyTime;
  float shieldDuration = 300, start, score, last, bonus;
  String notifyText;
  
  boolean shieldStatus;
  PImage shieldIcon = loadImage("shield (0).png");
  
  Status(){
    
  }
  
  int getGameState(){
    return gameState;
  }
  
  void setGameState(int i){
    gameState = i;
  }
  //score suff
  float getScore(){
    score = (millis()/1000 - start) + bonus;
    return score;
  }
  
  float getLastScore(){
    last = score;
    return last;
  }
  
  void addBonus(float i){
    bonus += i;
  }
  
  //shield stuff
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
  
  //reset
  void reset(){
    gameState = 1;
    bonus = 0;
    shieldDuration = 180;
  }
  
  void drawText(String s, float x, float y, int size) {
    //Text output method, string, xy coords, size of text
    textAlign(CENTER);
    textSize(size);
    text(s, x, y); 
  }
  
  void setNotifyText(String s, int i){
    notifyText = s;
    notifyTime = i;
  }
  
  void display(){
    //display shield stuff in top right
    image(shieldIcon, (width - 155), 30, iconWidth, iconHeight);
    String sDuration = nfs(getShieldDuration()/60, 1, 1);
    drawText(sDuration, (width - 157.5), 35, 12);
    
    switch(gameState){
      case 0:
        drawText("Score: " + (int)getLastScore(), width - 55, 35, 12);
        drawText("Game Over. Press 'r' to restart.", width/2, height/2, 20);
        break;
      case 1:
        //score currently adding seconds from before gamestart. Works properly on reset
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
        start = millis()/1000;
        drawText("Press SPACE to start", width/2, height/2, 20);
        drawText("Score: " + (int)getLastScore(), width - 55, 35, 12);
        break;
    }
    
    //displays notifications for a set amount of time to screen
    if (notifyTime > 0){
      drawText(notifyText, width/2, (height/2) - (height/4), 16);
      notifyTime--;
    }
  }
}

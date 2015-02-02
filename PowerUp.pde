abstract class PowerUp{
  PVector location;
  boolean used, played;
  Animation animation;
  //shieldCollect
  int count, frame = 1;
  PImage[] usedAnim;
  PowerUp(){
  
  }
  
  float getX(){
    return location.x;
  }
  
  void setX(float i){
    location.x = i;
  }
  
  float getY(){
    return location.y;
  }
  
  void setY(float i){
    location.y = i;
  }
  
  boolean getUsed(){
    return used;
  }
  
  void setUsed(boolean bool){
    used = bool;
  }
  
  void reset(float a, float b, float c, float d){
    setX(random(a, b));
    setY(random(c, d));
    used = false;
    played= false;
    frame = 1;
  } 
  
  abstract void collision(float x, float y, Status status);
  
  abstract void display();
}

class Shield extends PowerUp{
  PImage shieldImage = loadImage("shield.png");
  Shield(PVector location){
    this.location = location;
    //animation = new Animation("shield " , 72);
    count = 60;
    usedAnim = new PImage[count];
    
    for (int i = 1; i < count; i++){
      String name = "shieldCollect (" + i + ").png";
      usedAnim[i] = loadImage(name);
    }
  }
  
  void collision(float x, float y, Status status){
    if (getUsed() == false){
      if ((abs(location.x - x) < 50) && (abs(location.y - y) < 50)){
        setUsed(true);
        status.setShieldDuration(status.getShieldDuration() + 60);
        status.setNotifyText("Shield picked up!", 120);
      }
    }
  }
  
  void display(){
    if (used == false){ 
      image(shieldImage, location.x, location.y, 60, 50); 
    } else {
      if (played == false){
      image(usedAnim[frame], location.x, location.y, 60, 50);
        if (frame <= count) frame++;
        if (frame == count) played = true;
      }
    } 
    
    if (location.x < 0){ reset(900, 1800, 50, 350); }
  }
}

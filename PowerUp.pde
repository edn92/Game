abstract class PowerUp{
  boolean used;
  PVector location;
  Animation animation;
  
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
  
  void reset(float a, float b, float c, float d){
    setX(random(a, b));
    setY(random(c, d));
    used = false;
  } 
  
  abstract void collision(float x, float y, Status status);
  
  abstract void display();
}

class Shield extends PowerUp{
  Shield(PVector location){
    this.location = location;
    animation = new Animation("shield ", 84);
  }
  
  void collision(float x, float y, Status status){
    if (used == false){
      if ((abs(location.x - x) < 50) && (abs(location.y - y) < 50)){
        used = true;
        status.setShieldDuration(status.getShieldDuration() + 60);
        status.setNotifyText("Shield picked up!", 120);
      }
    }
  }
  
  void display(){
    /*if it hasnt been picked up, show powerup
      else, show pickup animation ONCE*/
    if (used == false){
      animation.display((int)location.x, (int)location.y, 50, 50);
    }
    
    if (location.x < 0){
      reset(900, 1800, 50, 350);
    }
  }
}

abstract class PowerUp{
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
  
  abstract void display();
}

class Shield extends PowerUp{
  Shield(PVector location){
    this.location = location;
    animation = new Animation("shield ", 84);
  }
  
  void display(){
    animation.display((int)location.x, (int)location.y, 50, 50);
  }
}

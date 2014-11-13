abstract class Obstacle{
  PVector location;
  Animation animation;
  
  Obstacle(){
  
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
  
  abstract void collision(float x, float y, Status status);
  
  abstract void display();
}

class Wall extends Obstacle{
  int wallWidth = 30;
  int wallHeight = height/2;
  
  Wall(PVector location){
    //new art later, change 1 to reflect amount of frames
    this.location = location;
    animation = new Animation("wall ", 1);
  }
  
  void collision(float x, float y, Status status){
    if ((abs(location.x - x) < (wallWidth/2)) && (abs(location.y - y) < (wallHeight/2))){
      //if (status.getShieldStatus() == false){ 
        status.setGameState(0); 
      //}
    }  
  }
  
  void display(){
    animation.display((int)location.x, (int)location.y, wallWidth, wallHeight);
  }
}

class Player{
  PVector location;
  Animation animation;
  
  Player(PVector location){
    this.location = location;
    
    animation = new Animation("player ", 72);
  }
  
  float getX(){
    return location.x;
  }
  
  float getY(){
    return location.y;
  }
  
  void startPosition(){
    location.x = 50;
    location.y = height/2;
  }
  
  void move(float x, float y){
    location.x += x;
    location.y += y;
  }
  
  void display(){
    animation.display((int)location.x, (int)location.y, 100, 100);
  }
}

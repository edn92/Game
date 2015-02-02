class Player{
  PVector location;
  Animation animation;
  float flyerWidth, flyerHeight;
  
  Player(PVector location, float flyerWidth, float flyerHeight){
    this.location = location;
    this.flyerWidth = flyerWidth;
    this.flyerHeight = flyerHeight;
    
    animation = new Animation("player ", 60);
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
    animation.display((int)location.x, (int)location.y, 100, 50);
  }
}



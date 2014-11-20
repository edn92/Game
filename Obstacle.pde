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
  
  void reset(float a, float b, float c, float d){
    //setX(random(a, b));
    location.x = random(a, b);
    location.y = random(c, d);
  }
  
  abstract void collision(float x, float y, Status status);
  
  abstract void display();
}

class Wall extends Obstacle{
  int wallWidth = 30;
  int wallHeight = (height * 2)/3;
  
  Wall(PVector location){
    //new art later, change 1 to reflect amount of frames
    this.location = location;
    animation = new Animation("wall ", 1);
  }
  
  void collision(float x, float y, Status status){
    if ((abs(location.x - x) < (wallWidth/2)) && (abs(location.y - y) < (wallHeight/2))){
      if (status.getShieldStatus() == false){ 
        status.setGameState(0); 
      }
    }  
  }
  
  void display(){
    animation.display((int)location.x, (int)location.y, wallWidth, wallHeight);
    if (location.x < 0){
      reset(location.x + width + 15, location.x + width + 15, 50, height - 50);
    }
  }
}

class Tracker extends Obstacle implements Clickable{
  //tracks and follows the player until destroyed
  int respawn;
  boolean destroyed;
  
  Tracker(PVector loc){
    this.location = loc;
    animation = new Animation("player " , 72);
  }
  
  void collision(float x, float y, Status status){
    if (respawn > 0){
      //println(respawn);
      respawn--;
      if (respawn == 0){
        destroyed = false;
      }
    }
    
    if (destroyed == false){
      if ((abs(location.x - x) < 25) && (abs(location.y - y) < 25)){
        if (status.getShieldStatus() == false) { 
          status.setGameState(0); 
        }
      } else {
        //follow the player
        if (location.y - y > 0){
          location.y -= 3;
        }
    
        if (location.y - y < 0){
          location.y += 3;
        } 
    
        if (location.x - x > 0){
          location.x -= 3;
        }
    
        if (location.x - x < 0){
          location.x += 3;
        }
      }
    }
  }
  
  void display(){
    if (destroyed == false){
      animation.display((int)location.x, (int)location.y, 100, 100);
    }
  }
  
  //getset destroy
  //getset respawn
  //play destroyed animation ONCE - written in seperate class like animation?
  
  boolean clicked(){
    //destroy when clicked
    if (mousePressed == true && destroyed == false){
      destroyed = true;
      status.addBonus(5);
      respawn = (int)random(600, 900);
      
      PVector m = new PVector(mouseX, mouseY);
      return (PVector.dist(location, m) < 35);
    }
    return false;
  }
}

class HorizontalBeam extends Obstacle{
  //fires a beam along x axis after delay
  HorizontalBeam(PVector location){
  
  }
  
  void collision(float x, float y, Status status){
  
  }
  
  void display(){
  
  }
}

class VerticalBeam extends Obstacle{
  //fires a beam along y axis after delay
  VerticalBeam(PVector location){
    
  }
  
  void collision(float x, float y, Status status){
  
  }
  
  void display(){
  
  }
}

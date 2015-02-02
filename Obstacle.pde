interface Clickable {
  boolean clicked();
}

abstract class Obstacle implements Clickable{
  PVector location;
  Animation animation;
  int obstacleWidth = 60, obstacleHeight = 60, respawn, count = 60, frame = 1;
  boolean destroyed, played;
  PImage[] destroyedAnim;
  
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
  
  boolean getDestroyed(){
    return destroyed;
  }
  
  void setRespawn(){
    respawn = (int)random(60, 300);
  }
  
  void reset(){
    location.x = width + 100;
    location.y = random(50, height - 100);
    
    destroyed = false;
    played = false;
    frame = 1;
  }
  //for restarting the game
  void reset(float x, float y){
    location.x = x;
    location.y = y;
    
    destroyed = false;
    played = false;
    frame = 1;
    respawn = 0;
  }
  
  void setDestroyed(boolean bool){
    destroyed = bool;
  }
  
  void whileDestroyed(){
    if (played == false){
        image(destroyedAnim[frame-1], location.x, location.y, obstacleWidth, obstacleHeight);
        if (frame <= count) frame++;
        if (frame == count) played = true;
      }
      
    if (respawn == 0){ reset(); } 
  }
  
  abstract void collision(float x, float y, Status status, float speed);
  abstract void display();
  
  boolean clicked(){
    PVector m = new PVector(mouseX, mouseY);
    return (PVector.dist(location, m) < 35);
  }
}

class Tracker extends Obstacle{
  //float xSpeed = 3, ySpeed = 2;
  AudioPlayer highlighterCollision;
  
  Tracker(PVector loc){
    this.location = loc;
    animation = new Animation("Highlighter ", 60);
    
    destroyedAnim = new PImage[count];
    
    for (int i = 1; i < count; i++){
      String name = "highlighterDestroyed (" + i + ").png";
      destroyedAnim[i-1] = loadImage(name);
    }
    
    highlighterCollision = minim.loadFile("7. Highlighter Collision.wav");
  }
  
  void collision(float x, float y, Status status, float speed){
    //cap y speed at 2 or weird stuff happens - still happens but less weird
    if (destroyed == false){
      if ((abs(location.x - x) < 25) && (abs(location.y - y) < 25)) {
        if (status.getShieldStatus() == false) { 
          highlighterCollision.play();
          highlighterCollision.rewind();
          status.setState(0); 
        }
        } else {
          if (location.y - y > 0){ setY(location.y - 2); } 
          else if (location.y - y < 0){ setY(location.y + 2); }
    
          if (location.x - x > 0){ setX(location.x - (1.25 * speed)); } 
          else if (location.x - x < 0){ setX(location.x + (1.25 * speed)); }
        }
    }
  }
  
  void display(){
    if (destroyed == false){ animation.display((int)location.x, (int)location.y, obstacleWidth, obstacleHeight); }
    else { 
      whileDestroyed();
      if (respawn > 0){ respawn--; }
    }
  }
}

class Stapler extends Obstacle{
// obstacle moves along x-axis only - stapler
  AudioPlayer staplerCollision;

  Stapler(PVector loc){
    this.location = loc;
    animation = new Animation("stapler ", 60);
    
    destroyedAnim = new PImage[count];
    
    for (int i = 1; i < count; i++){
      String name = "staplerDestroyed (" + i + ").png";
      destroyedAnim[i-1] = loadImage(name);
    }
    
    staplerCollision = minim.loadFile("6. Stapler Collision.wav");
  }
  
  void collision(float x, float y, Status status, float speed){
    if (destroyed == false && respawn == 0){ location.x = location.x - (2 * speed); }
    
    if ((abs(location.x - x) < 25) && (abs(location.y - y) < 25)) {
      if (status.getShieldStatus() == false && destroyed == false) { 
        //staplerCollision.play();
        //staplerCollision.rewind();
        status.setState(0); 
      }
    }
  }
  
  void display(){
    if (location.x < 0){
      respawn = (int)random(60, 120);
      reset();
    }
    if (respawn > 0){ respawn--; }
    
    if (destroyed == false){ animation.display((int)location.x, (int)location.y, obstacleWidth, obstacleHeight); }
    else { 
      whileDestroyed();
    }
  }
}

class Book extends Obstacle{
  float direction, velocity = 1;
  PImage bookImage = loadImage("book.png");
  
  AudioPlayer bookCollision;
  //should be .png
  Book(PVector loc){
    this.location = loc;
    
    destroyedAnim = new PImage[count];
    
    for (int i = 1; i < count; i++){
      String name = "bookDestroyed (" + i + ").png";
      destroyedAnim[i-1] = loadImage(name);
    }
    
    bookCollision = minim.loadFile("5. Book Impact.mp3");
  }
  
  void collision(float x, float y, Status status, float speed){
    if (destroyed == false && respawn == 0){
      location.x = location.x - (2 * direction);
      location.y = location.y + velocity;
      velocity+= 0.05;
    }
    //respawn if it goes off the map
    if (respawn > 0){ respawn--; }  
    
    if (location.x < 0 || location.y > height){
      respawn = (int)random(60, 120);
      destroyed = false;
      location.x = x + random(0, 300);
      location.y = 0 - obstacleHeight;
      velocity = random(0, 2);
      direction = random(-0.5, 0.5);
    }
    
    if ((abs(location.x - x) < 25) && (abs(location.y - y) < 25)) {
      if (status.getShieldStatus() == false && destroyed == false) { 
        bookCollision.play();
        bookCollision.rewind();
        status.setState(0); 
      }
    }
  }
  
  void display(){
  if (destroyed == false){ image(bookImage, location.x, location.y, obstacleWidth, obstacleHeight - 10); }
    else {
      whileDestroyed();
      if (played == false){
        image(destroyedAnim[frame-1], location.x, location.y, obstacleWidth, obstacleHeight - 10);
        if (frame <= count) frame++;
        if (frame == count) played = true;
      }
    }
  }
}

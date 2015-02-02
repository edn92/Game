abstract class Wall{
  PVector location;
  PVector topLocation;
  float wallWidth = 100, wallHeight = height - 150, leeway = 15;
  //collision leeway
  
  Wall(){
  }
  
  float getX(){
    return location.x;
  }
  
  void setX(float i){
    location.x = i;
    topLocation.x = i;
  }
  
  float getY(){
    return location.y;
  }
  
  void setY(float i){
    location.y = i;
    //topLocation.y 
  }
  
  void reset(float x, float a, float b){
    setX(x);
    setY(random(a, b));
    
    topLocation.y = location.y - random(wallHeight + 150, wallHeight + 450);
  } 
  
  abstract void collision(float x, float y, Status status);
  
  abstract void display(); 
}

class Shelf extends Wall{
  PImage light;
  PImage shelf;
  
  AudioPlayer lightCollision;
  AudioPlayer bookCollision;
  
  Shelf(PVector loc){
    this.location = loc;
    shelf = loadImage("bookshelf.png");
    light = loadImage("Light.png");
    
    topLocation = new PVector(location.x, location.y);
    topLocation.y = topLocation.y - random(wallHeight + 150, wallHeight + 450);
    
    lightCollision = minim.loadFile("4. Light Collision.mp3");
    bookCollision = minim.loadFile("3. Bookshelf Collision.wav");
  }
  
  void collision(float x, float y, Status status){
    if ((abs(location.x - x) < (wallWidth/2) + leeway) && (abs(location.y - y) < (wallHeight/2) + leeway)){
      if (status.getShieldStatus() == false){ 
        status.setState(0);
        bookCollision.play();
        bookCollision.rewind(); 
      }
    }
    
    if ((abs(topLocation.x - x) < (wallWidth/2) + leeway) && (abs(topLocation.y - y) < (wallHeight/2 + leeway))){
      if (status.getShieldStatus() == false){
        status.setState(0); 
        lightCollision.play();
        lightCollision.rewind();
      }
    }
  }
  
  void display(){
    imageMode(CENTER);
    image(shelf, location.x, location.y, wallWidth, wallHeight);
    image(light, topLocation.x, topLocation.y, wallWidth, wallHeight);
    
    if (location.x < -(wallWidth/2)){
      reset(width + 50, (height/2) + 100, height + 200);
    }
  }
}

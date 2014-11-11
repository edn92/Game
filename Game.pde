Player player;
//LinkedList<PowerUp> powerUps = new LinkedList();
//linkedlist don't appear to exist in processing?
ArrayList<PowerUp> powerUps = new ArrayList();

float powerUpsArraySize = 2;

float x, backgroundMoveSpeed = 2, playerMoveSpeed = 5;
boolean [] keys;

PImage background;

void setup(){
  size(800, 400);
  background = loadImage("background.jpg");
  player = new Player(new PVector(50, height/2));
  keys = new boolean[4];
  
  for (int i = 0; i < powerUpsArraySize; i++){
    powerUps.add(new Shield(new PVector(random(100, width), random(75, height - 75)))); 
  }
} 

void draw(){ 
  //display things
  background(0);
  imageMode(CORNER);
  image(background, x, 0, width, height);
  image(background, x + width, 0, width, height);
  
  player.display();
  for (int i = 0; i < powerUps.size(); i++){
    powerUps.get(i).display();
  }
  //run things
  
  x -= backgroundMoveSpeed;
  if (x <= - width){
    x += width;
  }
  
  keyboardInput();
}

void keyboardInput(){
    //if state = 1 do all of this
    if (keys[0]){ 
      if (player.getY() > 25){
        player.move(0, -playerMoveSpeed);
      } 
    }  
    
    if (keys[1]){ 
      if (player.getX() > 25){
        player.move(-(backgroundMoveSpeed + playerMoveSpeed), 0); 
      }
    }
    
    if (keys[2]){ 
      if (player.getY() < height -25){
        player.move(0, playerMoveSpeed); 
      }
    }
    
    if (keys[3]){ 
      if (player.getX() < width - 25){
        player.move(playerMoveSpeed, 0);
      }
    }
    
    //switch toggle shield, reset game
}

void keyPressed(){
  switch (key){
    case 'w':
      keys[0] = true;
      break;
    case 'a':
      keys[1] = true;
      break;
    case 's':
      keys[2] = true;
      break;
    case 'd':
      keys[3] = true;
      break;
  }
}

void keyReleased(){
  switch (key){
    case 'w':
      keys[0] = false;
      break;
    case 'a':
      keys[1] = false;
      break;
    case 's':
      keys[2] = false;
      break;
    case 'd':
      keys[3] = false;
      break;
  }
}

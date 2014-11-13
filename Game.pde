import java.util.*;

Player player;
Status status;
LinkedList<PowerUp> powerUps = new LinkedList();
LinkedList<Obstacle> obstacles = new LinkedList();

float powerUpsStartSize = 2, obstaclesStartSize = 2;

float x, backgroundMoveSpeed = 2, playerMoveSpeed = 5;
boolean [] keys;

PImage background;

void setup(){
  size(800, 400);
  background = loadImage("background.jpg");
  keys = new boolean[4];
  
  player = new Player(new PVector(50, height/2));
  status = new Status();
  
  for (int i = 0; i < powerUpsStartSize; i++){
    powerUps.add(new Shield(new PVector(random(100, width), random(75, height - 75)))); 
  }
  
  for (int i = 0; i < obstaclesStartSize; i++){
    obstacles.add(new Wall(new PVector(random(500, width), random(75, height - 75))));
  }
} 

void draw(){ 
  //display things
  background(0);
  imageMode(CORNER);
  image(background, x, 0, width, height);
  image(background, x + width, 0, width, height);
  
  for (int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).display();
  }
  
  for (int i = 0; i < powerUps.size(); i++){
    powerUps.get(i).display();
  }
  
  player.display();
  status.display();
  //run things if game is still going
  if (status.getGameState() == 1){
    //moves and resets background continuously
    x -= backgroundMoveSpeed;
    if (x <= - width){
      x += width;
    }
    
    //check collision with stuff
    for (int i = 0; i < powerUps.size(); i++){
      powerUps.get(i).collision(player.getX(), player.getY(), status);
      powerUps.get(i).setX(powerUps.get(i).getX() - backgroundMoveSpeed);
    }
    
    for (int i = 0; i < obstacles.size(); i++){
      obstacles.get(i).collision(player.getX(), player.getY(), status);
      obstacles.get(i).setX(obstacles.get(i).getX() - backgroundMoveSpeed);
    }
  }
  
  keyboardInput();
}

void keyboardInput(){
  //if state = 1 allow player to move
  if (status.getGameState() == 1){
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
  }  
    //switch toggle shield, reset game, start game
  switch(key){
    case ' ':
      if (status.getGameState() == 2){ 
        status.setGameState(1); 
      }
      break;
  }
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

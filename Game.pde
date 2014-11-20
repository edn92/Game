import java.util.*;

Player player;
Status status;
LinkedList<PowerUp> powerUps = new LinkedList();
LinkedList<Obstacle> walls = new LinkedList();
LinkedList<Obstacle> obstacles = new LinkedList();

float powerUpsStartSize = 2, wallsStartSize = 3, obstaclesStartSize = 1;
float x, backgroundMoveSpeed = 2, playerMoveSpeed = 5, increaseSpeedCountdown = 600;
/*
  x = background image x coord
  increaseSpeedCountdown = amount of time before speed increases. Currently starts increasing once a second after 10 seconds to give a smoother increase
*/
int keysSize = 5;

boolean [] keys;
boolean shieldToggle;
//allows shield to be toggled correctly on one hotkey
PImage background;

void setup(){
  size(800, 400);
  background = loadImage("background.jpg");
  keys = new boolean[keysSize];
  
  player = new Player(new PVector(50, height/2));
  status = new Status();
  
  for (int i = 0; i < powerUpsStartSize; i++){
    powerUps.add(new Shield(new PVector(random(100, width), random(75, height - 75)))); 
  }
  
  for (int i = 0; i < wallsStartSize; i++){
    walls.add(new Wall(new PVector(width/2 + (i * width/3), random(75, height - 75))));
  }
  
  for (int i = 0; i < obstaclesStartSize; i++){
    obstacles.add(new Tracker(new PVector(300, height/2)));
  }
} 

void draw(){ 
  //display things
  background(0);
  imageMode(CORNER);
  image(background, x, 0, width, height);
  image(background, x + width, 0, width, height);
  
  for (int i = 0; i < walls.size(); i++){
    walls.get(i).display();
  }
  
  for (int i = 0; i < powerUps.size(); i++){
    powerUps.get(i).display();
  }
  
  for (int i = 0; i < obstacles.size(); i++){
    obstacles.get(i).display();
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
    
    if (increaseSpeedCountdown == 00 && backgroundMoveSpeed < 100){
      backgroundMoveSpeed += 0.1;
      increaseSpeedCountdown = 60;
    } else {
      increaseSpeedCountdown--;
    }
    
    //check collision with stuff
    for (int i = 0; i < powerUps.size(); i++){
      powerUps.get(i).collision(player.getX(), player.getY(), status);
      powerUps.get(i).setX(powerUps.get(i).getX() - backgroundMoveSpeed);
    }
    
    for (int i = 0; i < walls.size(); i++){
      //if walls are too close to each other respawn
      walls.get(i).collision(player.getX(), player.getY(), status);
      walls.get(i).setX(walls.get(i).getX() - backgroundMoveSpeed);
    }
    
    for (int i = 0; i < obstacles.size(); i++){
      obstacles.get(i).collision(player.getX(), player.getY(), status);
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
    
    if (keys[4]){
      if (shieldToggle == false){
        shieldToggle = true;
        if (status.getShieldStatus() == true){
          status.setShieldStatus(false);
          status.setNotifyText("Deactivating shield!", 120);
        } else if (status.getShieldDuration() > 0){
          status.setShieldStatus(true);
          status.setNotifyText("Shielded!", 120);
        } else {
          status.setNotifyText("Shield depleted.", 120);
        }
      }
    }    
  }  
  switch(key){
    case 'r':
      if (status.getGameState() == 0){
        status.reset();
        player.startPosition();
        backgroundMoveSpeed = 2;
        
        //reset obstacles and walls
      }
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
    case '1':
      keys[4] = true;
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
    case '1':
      keys[4] = false;
      shieldToggle = false;
      break;  
  }
}

/*void mousePressed(){
  if (status.getGameState() == 1){
    for (int i = 0; i < obstacles.size(); i++){
      if (obstacles.get(i).clicked()){
        println("clicked on: " + i);
      }
    }
  }
}*/

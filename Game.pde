import ddf.minim.*;

Minim minim;
AudioPlayer shieldActivated;

Status status;
Player player;

Obstacle target;

ArrayList<Wall> bookShelves = new ArrayList();
ArrayList<Obstacle> obstacles = new ArrayList();
ArrayList<PowerUp> powerUps = new ArrayList();

float flyerWidth = 100, flyerHeight = 50, iconWidth = 70, iconHeight = 50; 
float bookShelvesArray = 2, obstaclesArray = 5, powerUpsArray = 2, backgroundMoveSpeed = 2, playerMoveSpeed = 5;
//countdown = framerate x 10
int countdown = 600, x = 0;
boolean [] keys;

PImage background;

void setup(){
  size (1000, 600);
  background = loadImage("background.png");
  
  minim = new Minim(this);
  shieldActivated = minim.loadFile("8. Shield Activated.wav");
  
  keys = new boolean[4];
  
  player = new Player(new PVector(50, height/2), flyerWidth, flyerHeight);
  status = new Status(iconWidth, iconHeight);
  
  addObstacle();  
  for (int i = 0; i < bookShelvesArray; i++){ 
    bookShelves.add(new Shelf(new PVector(width/2 + (i*(width/2)), random((height/2) + 100, height + 200)))); 
  }
  
  for (int i = 0; i < powerUpsArray; i++){
    powerUps.add(new Shield(new PVector(random(width - 100, width + 300), random(75, height - 75)))); 
  }
}

void addObstacle(){
  obstacles.add(new Tracker(new PVector(random(width, width + 200), random(50, height - 50))));
  obstacles.add(new Stapler(new PVector(random(width, width + 200), random(50, height - 50))));
  obstacles.add(new Book(new PVector(random(width + 200, width + 300), random(0, height))));
  obstacles.add(new Book(new PVector(random(width + 200, width + 300), random(0, height))));
  obstacles.add(new Book(new PVector(random(width + 200, width + 300), random(0, height))));
}

void draw(){
  background(0);
  imageMode(CORNER);
  image(background, x, 0, width, height);
  image(background, x + width, 0, width, height);
  
  imageMode(CENTER);
  
  input();
  //display
  for (int i = 0; i < bookShelves.size(); i++) { 
    bookShelves.get(i).display(); 
  }
  
  player.display();  
  
  for (int i = 0; i < obstacles.size(); i++) { 
    obstacles.get(i).display(); 
  }
  
  for (int i = 0; i < powerUps.size(); i++) {
    powerUps.get(i).display(); 
  }
  
  status.display();
  
  //if game is running do all of this stuff
  if (status.getState() == 1){
    x-= backgroundMoveSpeed;
    if (x <= -width) x += width;
    
    if (countdown == 0 && backgroundMoveSpeed < 10){
      backgroundMoveSpeed += 0.1;
      countdown = 60;
    } else { 
      countdown--; 
    }
    
    for (int i = 0; i < bookShelves.size(); i++) {
      bookShelves.get(i).collision(player.getX(), player.getY(), status);
      bookShelves.get(i).setX(bookShelves.get(i).getX() - backgroundMoveSpeed);
    }
    for (int i = 0; i < obstacles.size(); i++) {
      obstacles.get(i).collision(player.getX(), player.getY(), status, backgroundMoveSpeed);
    }
    for (int i = 0; i < powerUps.size(); i++) { 
      powerUps.get(i).collision(player.getX(), player.getY(), status);
      powerUps.get(i).setX(powerUps.get(i).getX() - backgroundMoveSpeed);
    }  
  }
}

void input(){
  if (status.getState() == 1){
    //In order WASD
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
  
  switch(key){
    case '1':
      if (status.getState() == 1){
        if (status.getShieldDuration() > 0){
          status.setShieldStatus(true);
          status.setNotifyText("Shielded!", 120);
          shieldActivated.play();
          shieldActivated.rewind();
        } else { 
          status.setNotifyText("Shield depleted.", 120); 
        }
      }
      break; 
      
    case '2':
      if (status.getState() == 1){
        status.setShieldStatus(false);
        status.setNotifyText("Deactivating shield!", 120);
      }
      break;
      
    case 'r':
      if (status.getState() == 0){
        player.startPosition();
        status.reset();
        backgroundMoveSpeed = 2;
       
        //rearrange starting positions
        for (int i = 0; i < bookShelves.size(); i++){ 
          bookShelves.get(i).reset(width/2 + i*(width/2), (height/2) + 100, height + 200); 
        }
        //staple and tracker
        for (int i = 0; i < 2; i++){  
          obstacles.get(i).reset(random(width - 100, width + 300), random(75, height - 75)); 
        }
        //book
        for (int i = 2; i < obstacles.size(); i++){ 
          obstacles.get(i).reset(random(width + 100, width + 200), random (0, height)); 
        }
      }
      break;
      
    case ' ':
      if (status.getState() == 2){ 
        status.setState(1); 
      }
      break;
    }
}

void mousePressed(){
  if (status.getState() == 1){
    for (int i = 0; i < obstacles.size(); i++){
      if (obstacles.get(i).clicked()){
        obstacles.get(i).setDestroyed(true);
        obstacles.get(i).setRespawn();
        status.addBonus();
      }
    }
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

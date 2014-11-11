class Animation{
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imageName, int count){
    imageCount = count;
    images = new PImage[imageCount];
    
    for (int i = 0; i < imageCount; i++){
      String name = imageName + "(" + i + ").png";
      images[i] = loadImage(name);
    }
  }
  
  void display(int x, int y, int resizeX, int resizeY){
    imageMode(CENTER);
    frame = (frame+1) % imageCount;  
    image(images[frame], x, y, resizeX, resizeY);
  }
}

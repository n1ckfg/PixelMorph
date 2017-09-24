PGraphics buffer;
PImage source, dest;
int baseSize = 256;
int counter = 0;

void setup() {
  size(50, 50, P2D);
  surface.setSize(baseSize*4, baseSize*4);
  buffer = createGraphics(baseSize, baseSize, P2D);
  source = createImage(baseSize, baseSize, RGB);
  dest = createImage(baseSize, baseSize, RGB);
}

void draw() {
  background(0);
  
  if (counter < 2) {
    if (mousePressed) {
      buffer.beginDraw();
      buffer.noStroke();
      buffer.fill(255, 0, 0);
      buffer.ellipse(mouseX/4, mouseY/4, 10, 10);
      buffer.endDraw();
    } 
  } else {
    for (int y = 0; y < buffer.height; y++) {
        for (int x = 0; x < buffer.width; x++) {
          int oldLoc = x + (y * buffer.width);
          int newX = (int) lerp(x, random(dest.width), 0.1);
          int newY = (int) lerp(y, random(dest.height), 0.1);
          int newLoc = newX + (newY * buffer.width);
          buffer.pixels[newLoc] = buffer.pixels[oldLoc];
        }
    }
    buffer.updatePixels();
  }
  image(buffer, 0, 0, width, height);
}

void keyPressed() {
  if (counter == 0) {
    source = buffer.get();
    source.loadPixels();

    buffer.beginDraw();
    buffer.clear();
    buffer.endDraw();
    
    counter = 1;
  } else if (counter == 1) {
    dest = buffer.get();
    dest.loadPixels();
    
    buffer.beginDraw();
    buffer.clear();
    buffer.image(source, 0, 0, width, height);
    buffer.endDraw();
    buffer.loadPixels();
    
    counter = 2;
  } else if (counter == 2) {
    counter = 0;
  }
}
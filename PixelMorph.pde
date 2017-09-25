PGraphics buffer;
PImage source, dest;
int modeCounter = 0;
int sW, sH;
int scaleFactor = 3;
color blankColor = color(0,0);
color sourceColor = color(255,0,0);
color destColor = color(0, 0, 255);
color nowColor = sourceColor;
int repCounter = 0;
int repMax = 200;
color[] sourcePixels, destPixels;

void setup() {
  size(256, 256, P2D);
  
  sW = width;
  sH = height;
  surface.setSize(width*scaleFactor, height*scaleFactor);
  buffer = createGraphics(sW, sH, P2D);
  source = createImage(sW, sH, RGB);
  dest = createImage(sW, sH, RGB);
  init();
}

void draw() {
  background(0);
  
  if (modeCounter < 2) {
    if (mousePressed) {
      buffer.beginDraw();
      buffer.stroke(nowColor);
      buffer.strokeWeight(10);
      buffer.line(mouseX/scaleFactor, mouseY/scaleFactor, pmouseX/scaleFactor, pmouseY/scaleFactor);
      buffer.endDraw();
    } 
  } else {
    if (repCounter < repMax) {
      for (int y = 0; y < buffer.height; y++) {
          for (int x = 0; x < buffer.width; x++) {
            int oldLoc = x + (y * buffer.width);
            
            int newX = (int) lerp((float) x, random(dest.width), 0.1);
            int newY = (int) lerp((float) y, random(dest.height), 0.1);
            int newLoc = newX + (newY * buffer.width);
            
            color oldC = buffer.pixels[oldLoc];
            color newC = buffer.pixels[newLoc];
            if (oldC != blankColor) {
              float oldR = red(oldC);
              float oldG = green(oldC);
              float oldB = blue(oldC);
              float oldA = alpha(oldC);
              
              float newR = red(newC);
              float newG = green(newC);
              float newB = blue(newC);
              float newA = alpha(newC);
              
              float lerpR = lerp(oldR, newR, 0.1);
              float lerpG = lerp(oldG, newG, 0.1);
              float lerpB = lerp(oldB, newB, 0.1);
              float lerpA = lerp(oldA, newA, 0.1);
              
              color lerpC = color(lerpR, lerpG, lerpB, lerpA);
             
              if (lerpC != blankColor) {
                buffer.pixels[newLoc] = lerpC;
              }
            }
          }
      }
      buffer.updatePixels();
      repCounter++;
    }
  }
  image(buffer, 0, 0, width, height);
}

void clearBuffer() {
  buffer.loadPixels();
  for(int i=0; i<buffer.pixels.length; i++) {
    buffer.pixels[i] = blankColor;
  }
  buffer.updatePixels();
}

color[] getNonAlphaPixels(color[] input) {
  IntList returnList = new IntList();
  for (int i=0; i<input.length; i++) {
    if (input[i] != blankColor) returnList.append(input[i]);
  }
  return returnList.array();
}
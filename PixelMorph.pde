
Grid grid;
int sW, sH;
int scaleFactor = 3;


color[] sourcePixels, destPixels;

void setup() {
  size(256, 256, P2D);
  
  sW = width;
  sH = height;
  grid = new Grid(sW, sH);
  
  surface.setSize(width*scaleFactor, height*scaleFactor);
}

void draw() {
  background(0);
  
  if (grid.modeCounter < 2) {
    if (mousePressed) {
      grid.buffer.beginDraw();
      grid.buffer.stroke(grid.nowColor);
      grid.buffer.strokeWeight(10);
      grid.buffer.line(mouseX/scaleFactor, mouseY/scaleFactor, pmouseX/scaleFactor, pmouseY/scaleFactor);
      grid.buffer.endDraw();
    } 
  }
  
  grid.run();
}
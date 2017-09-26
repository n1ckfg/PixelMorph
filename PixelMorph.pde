Grid grid;
int sW, sH;
int scaleFactor = 3;
PFont font;
int fontSize = 18;

void setup() {
  size(256, 256, P2D);
  
  sW = width;
  sH = height;
  grid = new Grid(sW, sH);
  font = createFont("Arial", fontSize);
  textFont(font);
  
  surface.setSize(width*scaleFactor, height*scaleFactor);
  
  bloomSetup();
}

void draw() {
  background(0);
  
  grid.run();
  
  bloomDraw();
  text(""+grid.modeCounter, fontSize, fontSize*1.5);
}
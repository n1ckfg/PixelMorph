Grid grid;
int sW, sH;
int scaleFactor = 6;
PFont font;
int fontSize = 28;

void setup() {
  size(128, 128, P2D);
  
  sW = width;
  sH = height;
  grid = new Grid(sW, sH);
  font = loadFont("Arial120.vlw");
  textFont(font, fontSize);
  
  surface.setSize(width*scaleFactor, height*scaleFactor);
  
  bloomSetup();
}

void draw() {
  background(0);
  
  grid.run();
  
  bloomDraw();
  text(""+(grid.modeCounter+1), fontSize, fontSize*1.5);
  
  surface.setTitle("" + frameRate);
}
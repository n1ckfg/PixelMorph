Grid grid;
int sW, sH;
int scaleFactor = 5;
PFont font;
int fontSize = 28;
Scanner scanner;

void setup() {
  size(192, 108, P2D);
  
  sW = width;
  sH = height;
  grid = new Grid(sW, sH);
  font = loadFont("Arial120.vlw");
  textFont(font, fontSize);
  
  surface.setSize(width*scaleFactor, height*scaleFactor);
  
  bloomSetup();
  scanner = new Scanner(-1);
}

void draw() {
  background(0);
  
  grid.run();
  
  if (grid.modeCounter == 2) {
    tex.loadPixels();
    scanner.run();
  }
  
  bloomDraw();
  text(""+(grid.modeCounter+1), fontSize, fontSize*1.5);
  
  surface.setTitle("" + frameRate);
}
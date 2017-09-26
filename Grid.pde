class Grid {

  int gridWidth, gridHeight;
  ArrayList<Dot> dots;
  PImage input, output;
  PGraphics buffer;
  int modeCounter = 0;
  int repCounter = 0;
  int repMax = 200;
  color blankColor = color(0,0);
  color sourceColor = color(255,0,0);
  color destColor = color(0, 0, 255);
  color nowColor = sourceColor;

  Grid(int _width, int _height) {
    gridWidth = _width;
    gridHeight = _height;
    input = output = createImage(gridWidth, gridHeight, RGB);
    buffer = createGraphics(gridWidth, gridHeight, P2D);
    init();
  }
  
  void advanceMode() {
    if (modeCounter == 0) {
      getInput();
      modeCounter = 1;
      nowColor = destColor;
      clearBuffer();
    } else if (modeCounter == 1) {
      getOutput();
      modeCounter = 2;      
      clearBuffer();
      importPix(input, output);
    } else if (grid.modeCounter == 2) {
      init();
    }
  }
  
  void init() {
    repCounter = 0;
    modeCounter = 0;
    nowColor = sourceColor;
    clearBuffer();
  }

  void getInput() {
    input = buffer.get();
    input.loadPixels();
  }
  
  void getOutput() {
    output = buffer.get();
    output.loadPixels();
  }
  
  void importPix(PImage input, PImage output) {
    dots = new ArrayList<Dot>();
    for (int y = 0; y < gridHeight; y++) {
      for (int x = 0; x < gridWidth; x++) {
        int loc = x + (y * gridWidth);
        PVector p = new PVector(x, y);
        PVector t = new PVector(x, y);
        color pc = input.pixels[loc];
        color tc = output.pixels[loc];
        dots.add(new Dot(p, t, pc, tc));
      }
    }
  }
  
  void exportPix() {
    buffer.loadPixels();
    for (int i=0; i<dots.size(); i++) {
      Dot d = dots.get(i);
      int loc = int(d.p.x + (d.p.y * gridWidth));
      buffer.pixels[loc] = d.pc;
    }
    buffer.updatePixels();
  }
    
  void update() {
    if (modeCounter == 2 && grid.repCounter < grid.repMax) {
      for (int i=0; i<dots.size(); i++) {
        dots.get(i).run();
      }
      exportPix();
      repCounter++;
    }
  }
    
  void draw() {
    image(buffer, 0, 0, width, height);
  }
  
  void run() {
    update();
    draw();
  }
  
  void clearBuffer() {
    buffer.beginDraw();
    buffer.loadPixels();
    for(int i=0; i<buffer.pixels.length; i++) {
      buffer.pixels[i] = blankColor;
    }
    buffer.updatePixels();
    buffer.endDraw();
  }
  
  color[] getNonAlphaPixels(color[] input) {
    IntList returnList = new IntList();
    for (int i=0; i<input.length; i++) {
      if (input[i] != blankColor) returnList.append(input[i]);
    }
    return returnList.array();
  }
  
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

class Dot {

  PVector p;
  PVector t;
  color pc, tc;
  float s = 0.1;
  
  Dot() {
    p = new PVector(width/2, height/2);
    pc = tc = color(0);
  }
  
  Dot(PVector _p, color _pc) {
    p = _p;
    pc = _pc;
  }
  
  Dot(PVector _p, PVector _t, color _pc, color _tc) {
    p = _p;
    t = _t;
    pc = _pc;
    tc = _tc;
  }
  
  Dot(PVector _p, PVector _t, color _pc, color _tc, float _s) {
    p = _p;
    t = _t;
    pc = _pc;
    tc = _tc;
    s = _s;
  }
  
  void run() {
    float x = lerp(p.x, t.x, s);
    float y = lerp(p.y, t.y, s);
    float r = lerp(red(pc), red(tc), s);
    float g = lerp(green(pc), green(tc), s);
    float b = lerp(blue(pc), blue(tc), s);
    float a = lerp(alpha(pc), alpha(tc), s);
    
    p = new PVector(x, y);
    pc = color(r,g,b,a);
  }

}
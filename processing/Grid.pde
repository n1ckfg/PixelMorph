class Grid {

  int gridWidth, gridHeight;
  ArrayList<Dot> dots;
  PImage input, output;
  PGraphics buffer;
  int modeCounter = 0;
  int repCounter = 0;
  int repMax = 1000;
  color blankColor = color(0,0);
  color sourceColor = color(255,0,0);
  color destColor = color(0, 0, 255);
  color nowColor = sourceColor;
  float speed = 0.01;
  int strokeSize = 3;

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
      try {
        importPix(input, output);
      } catch (Exception e) {
        init();
      }
    } else if (grid.modeCounter == 2) {
      init();
    }
  }
  
  void importPix(PImage input, PImage output) {
    dots = new ArrayList<Dot>();

    ArrayList<Dot> inputDots = getNonBlankDots(input);
    ArrayList<Dot> outputDots = getNonBlankDots(output);
       
    int iDotSize = inputDots.size();
    int oDotSize = outputDots.size();
    println(iDotSize + " " + oDotSize);

    for (int i=0; i < oDotSize; i++) {
      int iDotIndex = constrain(i, 0, iDotSize-1);
      dots.add(getDot(inputDots.get(iDotIndex), outputDots.get(i)));
    }
  }
  
  Dot getDot(Dot d1, Dot d2) {
    Dot d = new Dot();
    d.p = d1.p;
    d.pc = d1.pc;
    d.t = d2.p;
    d.tc = d2.pc;
    d.s = speed;
    return d;
  }
  
  ArrayList<Dot> getNonBlankDots(PImage input) {
    ArrayList<Dot> returns = new ArrayList<Dot>();
    
    for (int y = 0; y < input.height; y++) {
      for (int x = 0; x < input.width; x++) {
        int loc = x + (y * input.width);
        PVector p = new PVector(x, y);
        color pc = input.pixels[loc];
        if (pc != blankColor) returns.add(new Dot(p, pc));
      }
    }    
    
    return returns;
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
    if (modeCounter < 2) {
      if (mousePressed) {
        buffer.beginDraw();
        buffer.stroke(grid.nowColor);
        buffer.strokeWeight(strokeSize);
        buffer.line(mouseX/scaleFactor, mouseY/scaleFactor, pmouseX/scaleFactor, pmouseY/scaleFactor);
        buffer.endDraw();
      } 
    } else if (modeCounter == 2 && repCounter < repMax) {
      for (int i=0; i<dots.size(); i++) {
        dots.get(i).run();
      }
      exportPix();
      repCounter++;
    }
  }
    
  void draw() {
    tex.beginDraw();
    tex.background(0);
    tex.image(buffer, 0, 0, width, height);
    tex.noStroke();
    tex.fill(0, 80 + random(20));
    tex.rect(0,0,width,height);
    if (modeCounter == 2) {
      for (int i=0; i<dots.size(); i++) {
        Dot d = dots.get(i);
        tex.stroke(d.pc);
        tex.strokeWeight(strokeSize);
        tex.point(d.p.x * scaleFactor, d.p.y * scaleFactor);
      }
    }
    tex.endDraw();
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
  
  String logDotInfo(Dot d) {
     return d.p + " " + d.pc + " " + d.t + " " + d.tc;
  }
  
}
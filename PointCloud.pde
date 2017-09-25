class PointCloud {

  Grid source, dest, current;
  
  PointCloud(int w, int h) {
    source = dest = current = new Grid(createGraphics(w, h, P2D));
  }
  
  void update() {
    //
  }
  
  void draw() {
    image(current.exportGfx(), 0, 0);
  }
  
  void run() {
    update();
    draw();
  }
  
}

// ~ ~

class Grid {

  int gridWidth, gridHeight;
  ArrayList<Dot> dots;

  Grid(PGraphics input) {
    importGfx(input);
  }
  
  void importGfx(PGraphics input) {
    gridWidth = input.width;
    gridHeight = input.height;
    dots = new ArrayList<Dot>();
    for (int y = 0; y < gridHeight; y++) {
      for (int x = 0; x < gridWidth; x++) {
        int loc = x + (y * gridWidth);
        PVector p = new PVector(x, y);
        color c = input.pixels[loc];
        dots.add(new Dot(p, c));
      }
    }
  }
  
  PGraphics exportGfx() {
    PGraphics returns = createGraphics(gridHeight, gridWidth);
    returns.loadPixels();
    for (int i=0; i<dots.size(); i++) {
      Dot d = dots.get(i);
      int loc = int(d.p.x + (d.p.y * gridWidth));
      returns.pixels[loc] = d.c;
    }
    returns.updatePixels();
    return returns;
  }
  
}

// ~ ~ 

class Dot {

  PVector p;
  color c;
  
  Dot(PVector _p, color _c) {
    p = _p;
    c = _c;
  }
  
}
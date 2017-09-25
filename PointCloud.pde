class PointCloud {

  ArrayList<Dot> dots;

  PGraphics buffer;
  PImage source, dest;
  
  PointCloud() {
    dots = new ArrayList<Dot>();
  }
  
  void update() {
  }
  
  void draw() {
  }
  
  void run() {
    update();
    draw();
  }
  
}
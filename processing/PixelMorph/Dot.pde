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
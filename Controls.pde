void keyPressed() {
  if (modeCounter == 0) {
    source = buffer.get();
    source.loadPixels();
    sourcePixels = getNonAlphaPixels(source.pixels);
    modeCounter = 1;
    nowColor = destColor;

    buffer.beginDraw();
    clearBuffer();
    buffer.endDraw();
  } else if (modeCounter == 1) {
    dest = buffer.get();
    dest.loadPixels();
    destPixels = getNonAlphaPixels(dest.pixels);
    modeCounter = 2;
    
    buffer.beginDraw();
    clearBuffer();
    buffer.image(source, 0, 0, sW, sH);
    buffer.endDraw();
    buffer.loadPixels();
  } else if (modeCounter == 2) {
    init();
  }
}

void init() {
  repCounter = 0;
  modeCounter = 0;
  nowColor = sourceColor;
  
  buffer.beginDraw();
  clearBuffer();
  buffer.endDraw();
}

void mousePressed() {
  if (modeCounter == 2) {
    init();
  }
}
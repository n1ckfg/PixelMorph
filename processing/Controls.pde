void keyPressed() {
  grid.advanceMode();
}

void mousePressed() {
  if (grid.modeCounter == 2) {
    grid.advanceMode();
  }
}
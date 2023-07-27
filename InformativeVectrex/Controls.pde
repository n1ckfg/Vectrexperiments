boolean drawDebug = false;

void keyReleased() {
  if (key == 'd') {
    drawDebug = !drawDebug;
  } else if (key == 'c') {
    clearEveryFrame = !clearEveryFrame;
  }
}

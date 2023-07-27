import processing.video.Capture;

Capture cam;
PGraphics frame;
PImage result;

void videoSetup() {
  cam = new Capture(this, "pipeline:autovideosrc");
  result = createImage(512, 512, RGB);
  frame = createGraphics(512, 512, JAVA2D);
  cam.start();
}

void videoUpdate() {
  if (cam.available()) {
    cam.read();
    frame.beginDraw();
    frame.image(cam, -85, 0, 682, 512);
    frame.endDraw();
    result = modelInference(frame);
  } else if (cam.width == 0) {
    return;
  }
}

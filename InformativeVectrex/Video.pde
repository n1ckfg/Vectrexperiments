import processing.video.Capture;

Capture cam;
PImage result;

void videoSetup() {
  cam = new Capture(this, "pipeline:autovideosrc");
  result = createImage(cam.width, cam.height, RGB);
  cam.start();
}

void videoUpdate() {
  if (cam.available()) {
    cam.read();
    result = modelInference(cam);
  } else if (cam.width == 0) {
    return;
  }
}

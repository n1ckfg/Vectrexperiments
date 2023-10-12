import processing.video.Capture;

Capture cam;
PGraphics frame;

void videoSetup() {
  cam = new Capture(this, "pipeline:autovideosrc");
  frame = createGraphics(512, 512, P2D);
  cam.start();
}

void videoUpdate() {
  if (cam.available()) {
    cam.read();
    frame.beginDraw();
    frame.image(cam, -85, 0, 682, 512);
    frame.endDraw();
    
    contourUpdate();   
   
  } else if (cam.width == 0) {
    return;
  }
}

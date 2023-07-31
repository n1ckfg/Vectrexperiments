import processing.video.Capture;

Capture cam;
PGraphics frame;
PShader shader_edge;
boolean invert = true;

void videoSetup() {
  cam = new Capture(this, "pipeline:autovideosrc");
  frame = createGraphics(sW, sH, P2D);
  frame.loadPixels();
  
  shader_edge = loadShader("sobel_edge.glsl");
  shader_edge.set("iResolution", float(frame.width), float(frame.height));
  shader_edge.set("tex0", frame);
  
  cam.start();
}

void videoUpdate() {
  if (cam.available()) {
    cam.read();
    frame.beginDraw();
    frame.image(cam, 0, 0, frame.width, frame.height); //-85, 0, 682, 512);
    frame.filter(shader_edge);
    if (invert) frame.filter(INVERT);
    frame.endDraw();   
  } else if (cam.width == 0) {
    return;
  }
}

import processing.video.*;

Movie movie;
Capture capture;
int captureIndex = 0;
int camW = 640;
int camH = 480;
int camFps = 30;
boolean liveCapture = true;
String movieUrl = "test.mp4";
boolean movieLoop = false;
boolean autoVideoSource = false;

PGraphics frame;
PShader shader_edge;
boolean invert = true;

void captureSetup() {
  if (autoVideoSource) {
    capture = new Capture(this, "pipeline:autovideosrc");
  } else {
    capture = new Capture(this, camW, camH, Capture.list()[captureIndex], camFps);
  }
  capture.start(); 
}

void movieSetup() {
  movie = new Movie(this, movieUrl);
  if (movieLoop) movie.loop();
  movie.play(); 
}

void videoSetup() {
  if (liveCapture) {
    captureSetup();
  } else {
    movieSetup();
  }
  
  frame = createGraphics(sW, sH, P2D);
  frame.loadPixels();
  
  shader_edge = loadShader("sobel_edge.glsl");
  shader_edge.set("iResolution", float(frame.width), float(frame.height));
  shader_edge.set("tex0", frame); 
}

void captureEvent(Capture c) {
  c.read();
}

void movieEvent(Movie m) {
  m.read();
}

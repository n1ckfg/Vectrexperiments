int sW = 240;
int sH = 180;

void setup() {
  size(50, 50, P2D);
  surface.setSize(sW, sH);
  
  videoSetup();
  xyScopeSetup();
  skeletonSetup(); 
}  

void draw() {  
  background(0);
  if (drawDebug) image(frame, 0, 0);
  
  if (liveCapture) {
    drawFrame(capture);
  } else {
    drawFrame(movie);
  }
  
  surface.setTitle("" + frameRate);
}


void drawFrame(PImage img) {
  frame.beginDraw();
  frame.image(img, 0, 0, frame.width, frame.height); 
  frame.filter(shader_edge);
  if (invert) frame.filter(INVERT);
  frame.endDraw();     
  
  skeletonDraw();      
}

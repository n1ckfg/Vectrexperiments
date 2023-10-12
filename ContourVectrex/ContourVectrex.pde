import processing.javafx.*;

void setup() {
  size(512, 512, P2D);
   
  videoSetup();
  xyScopeSetup();
  contourSetup();
}  

void draw() {
  xyScopeBegin();
  
  background(0);
  videoUpdate();
  
  contourDraw();
  
  xyScopeEnd();
  surface.setTitle("" + frameRate);
}

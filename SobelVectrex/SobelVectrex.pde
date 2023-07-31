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
  videoUpdate();
  if (drawDebug) image(frame, 0, 0);  
  skeletonDraw();      
  surface.setTitle("" + frameRate);
}

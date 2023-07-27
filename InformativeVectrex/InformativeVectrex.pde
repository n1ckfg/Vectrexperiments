void setup() {
  size(512, 512, FX2D);
   
  modelSetup();

  videoSetup();
  xyScopeSetup();
  skeletonSetup(); 
}  

void draw() {
  xyScopeBegin();
  
  background(0);
  videoUpdate();
  
  if (drawDebug) image(result, 0, 0);  
  skeletonDraw();
  
  xyScopeEnd();
  surface.setTitle("" + frameRate);
}

void setup() {
  size(640, 480, FX2D);
   
  modelSetup();

  videoSetup();
  xyScopeSetup();

  surface.setSize(cam.width, cam.height);
}  

void draw() {
  videoUpdate();
  
  if (drawDebug) {
    image(result, 0, 0, width, height);
    
    
  } else {
    image(result, 0, 0, width, height);
  }

  surface.setTitle("" + frameRate);
}

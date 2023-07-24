PGraphics3D p3d;
PMatrix3D proj, modvw, modvwInv, screen2Model, model2Screen;  
PVector mouse, pos, poi, up, right, forward;

void defaultPos() {
  pos = new PVector(0,0,0);
  pos.x = width/2.0;
  pos.y = height/2.0;
  pos.z = (height/2.0) / tan(PI*30.0 / 180.0);
}

void defaultPoi() {
  poi = new PVector(0,0,0);
  poi.x = width/2.0;
  poi.y = height/2.0;
  poi.z = 0;
}
  
void initCam() {
  defaultPos();
  defaultPoi();
  up = new PVector(0, 1, 0);
  right = new PVector(1, 0, 0);
  forward = new PVector(0, 0, 1);
}
 
void drawCam(){
  camera(pos.x, pos.y, pos.z, poi.x, poi.y, poi.z, up.x, up.y, up.z);
}
  
void initMats() {
  p3d = (PGraphics3D) g;
  proj = new PMatrix3D();
  modvw = new PMatrix3D();
  modvwInv = new PMatrix3D();
  screen2Model = new PMatrix3D(); 
}

PVector screenToWorldCoords(PVector p) {
  modvw = p3d.modelview.get();
  modvwInv = p3d.modelviewInv.get();
  screen2Model = modvwInv;
  screen2Model.apply(modvw);
  float screen[] = { p.x, p.y, p.z };
  float model[] = { 0, 0, 0 };
  model = screen2Model.mult(screen, model);
  
  PVector returns = new PVector(model[0] + (poi.x - width/2), model[1] + (poi.y - height/2), model[2]);
  println(returns);
  return returns;
}

void screenToWorldMouse() {
  mouse = screenToWorldCoords(new PVector(mouseX, mouseY, poi.z));
}

// https://webglfactory.blogspot.com/2011/05/how-to-convert-world-to-screen.html
PVector worldToScreenCoords(PVector point3D) {
  proj = p3d.projection.get();
  modvw = p3d.modelview.get();
  model2Screen = proj;
  model2Screen.apply(modvw);
  // transform world to clipping coordinates
  float world[] = { point3D.x, point3D.y, point3D.z };
  float screen[] = { 0, 0, 0 };

  screen = model2Screen.mult(world, screen);
  float x = ((screen[0] + 1) / 2.0) * width;
      
  // we calculate -point3D.getY() because the screen Y axis is oriented top->down 
  float y = ((1 - screen[1]) / 2.0) * height;
  
  return new PVector(x, y);
}

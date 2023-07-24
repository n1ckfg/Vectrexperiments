// cc teddavis.org 2018

import ddf.minim.*; // minim req to gen audio
import xyscope.*;   // import XYscope
import latkProcessing.*;

XYscope xy;         // create XYscope instance
Latk latk; 
  
void setup() {
  size(512, 512, P3D); 

  xy = new XYscope(this); // define XYscope instance
  //xy.getMixerInfo(); // lists all audio devices

  xy.vectrex(0); // 90 for landscape, 0 for portrait
  xy.ellipseDetail(30); // set detail of vertex ellipse

  /*
   If the SPOT-KILLER MOD was applied (z/brightness is always on),
   this auto sets the brightness (from way turned down) when the sketch runs.
   */
  //xy.z("MOTU 3-4"); // use custom 3rd channel audio device
  //xy.zRange(.5, 0);

  latk = new Latk(this, "jellyfish.latk");  

  //float fov = PI/3.0;
  //float cameraZ = (height/2.0) / tan(fov/2.0);
  //perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  
  initMats();
}

void draw() {
  background(0);
  
  pushMatrix();
  translate(190, 220, 200);
  latk.run();
  popMatrix();
  
  println(latk.layers.get(0).currentFrame);
  for (int i=0; i<latk.layers.size(); i++) {
    LatkLayer layer = latk.layers.get(i);
    LatkFrame frame = layer.frames.get(layer.currentFrame);
    for (int j=0; j<frame.strokes.size(); j++) {
      LatkStroke stroke = frame.strokes.get(j);
      for (int k=0; k<stroke.points.size(); k++) {
        PVector point = worldToScreenCoords(stroke.points.get(k).co);
        xy.point(point.x, point.y);
      }
    }
  }
  
  xy.buildWaves(); // build audio from shapes
  //xy.drawAll(); // draw all analytics

  surface.setTitle(""+frameRate);
}

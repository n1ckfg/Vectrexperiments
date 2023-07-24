// cc teddavis.org 2018

import ddf.minim.*; // minim req to gen audio
import xyscope.*;   // import XYscope
XYscope xy;         // create XYscope instance

void setup() {
  size(512, 512, P2D); 

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
}

void draw() {
  background(0);
  
  xy.buildWaves(); // build audio from shapes
  xy.drawAll(); // draw all analytics
}

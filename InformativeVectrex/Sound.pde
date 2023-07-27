// cc teddavis.org 2018

import ddf.minim.*; // minim req to gen audio
import xyscope.*;   // import XYscope

XYscope xy;         // create XYscope instance
boolean debugXyScope = false;

void setupXyScope() {
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

void beginXyScope() {
  
}

void endXyScope() {
  xy.buildWaves(); // build audio from shapes
  if (debugXyScope) xy.drawAll(); // draw all analytics
}

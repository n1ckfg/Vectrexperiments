import ddf.minim.*; // minim req to gen audio
import xyscope.*;   // import XYscope
XYscope xy;         // create XYscope instance

String filePath = "nap/shark.nap";
TelidonDraw telidon;
//PFont font;
//int fontSize = 36;

void setup() {
  size(640, 640, P2D);
  telidon = new TelidonDraw(filePath);

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
  
  //font = loadFont("Telidon-48.vlw");
  background(0);
  blendMode(ADD);
}

void draw() {
  //xy.clearWaves();

  background(0);
  telidon.draw();

  xy.buildWaves(); // build audio from shapes
}

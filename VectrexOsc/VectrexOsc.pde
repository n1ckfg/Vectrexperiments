import ddf.minim.*; // minim req to gen audio
import xyscope.*;   // import XYscope
XYscope xy;         // create XYscope instance

ArrayList<Stroke> strokesBuffer;
int globalLifespan = 1000;
float dotSize = 1;
int globalAlpha = 255;

void setup() {
  size(512, 512, P2D);
  strokesBuffer = new ArrayList<Stroke>();
  oscSetup();
  
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
  xy.clearWaves();

  for (int i=0; i<strokesBuffer.size(); i++) {
    try {
      strokesBuffer.get(i).draw();
    } catch (Exception e) { }
  }
    
  xy.buildWaves(); // build audio from shapes
}

void createStroke(int index, color c, ArrayList<PVector> points) {
  Stroke newStroke = new Stroke(index, c, points, globalLifespan);

  boolean doReplace = false;
  int replaceIndex = 0;
  
  for (int i=0; i<strokesBuffer.size(); i++) {
    Stroke s = strokesBuffer.get(i);
    if (s.index == index) {
      replaceIndex = i;
      doReplace = true;
      break;
    }
  }
      
  if (doReplace) {
    strokesBuffer.set(replaceIndex, newStroke);
  } else {
    strokesBuffer.add(newStroke);
  }

  int time = millis();
  for (int i=0; i<strokesBuffer.size(); i++) {
    Stroke s = strokesBuffer.get(i);
    if (time > s.timestamp + s.lifespan) {
      strokesBuffer.remove(i);
    }
  }  
}

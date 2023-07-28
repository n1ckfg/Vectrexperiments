// cc teddavis.org 2018

import ddf.minim.*; // minim req to gen audio
import xyscope.*;   // import XYscope
import latkProcessing.*;

TiltLoader tl;
Latk latk; 
PVector offset = new PVector(40, -100);
int skipPoints = 1;

void setup() {
  size(512, 512, P3D); 
  
  xyScopeSetup();

  tl = new TiltLoader(this, "Untitled_2.tilt");  
  latk = new Latk(this);  
  
  for (TiltStroke ts : tl.strokes) {
    LatkStroke stroke = new LatkStroke(this, new ArrayList<LatkPoint>(), ts.brushColor);
    
    for (PVector p : ts.positions) {
      stroke.points.add(new LatkPoint(this, p));
    }
    
    LatkLayer layer = latk.layers.get(0);
    LatkFrame frame = layer.frames.get(layer.currentFrame);
    if (stroke.points.size() > 1) frame.strokes.add(stroke);
  }  
  
  latk.normalize();

  for (int i=0; i<latk.layers.size(); i++) {
    LatkLayer layer = latk.layers.get(i);
    for (int j=0; j<layer.frames.size(); j++) {
      LatkFrame frame = layer.frames.get(j);
      for (int k=0; k<frame.strokes.size(); k++) {
        LatkStroke stroke = frame.strokes.get(k);
        
        for (int l=0; l<stroke.points.size(); l++) {
          PVector point = stroke.s.getVertex(l);
          point.x = abs(point.x * width) + offset.x;
          point.y = (height - abs(point.y * height)) + offset.y;
          stroke.s.setVertex(l, point);
        }
      }
    }
  }
}

float rot = 0;

void draw() {
  background(0);
  
  latk.run();  

  pushMatrix();
  rot += 0.01;
  rotateY(rot);
  translate(width/2, height/2);
  
  xyScopeBegin();
  
  println(latk.layers.get(0).currentFrame);
  for (int i=0; i<latk.layers.size(); i++) {
    LatkLayer layer = latk.layers.get(i);
    LatkFrame frame = layer.frames.get(layer.currentFrame);
    for (int j=0; j<frame.strokes.size(); j++) {
      LatkStroke stroke = frame.strokes.get(j);
      
      xy.beginShape();
      for (int k=0; k<stroke.points.size(); k+=skipPoints) {
        PVector point = stroke.s.getVertex(k);
        xy.vertex(point.x, point.y, point.z);
      }
      xy.endShape();
    }
  }
   
  xyScopeEnd();
  popMatrix();

  surface.setTitle(""+frameRate);
}

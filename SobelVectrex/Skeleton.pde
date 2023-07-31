import java.io.*;
import java.lang.reflect.*;
import java.lang.*;
import java.awt.geom.AffineTransform;
import java.util.*;
//import traceskeleton.*;

ArrayList<ArrayList<int[]>>  c;
ArrayList<int[]> rects = new ArrayList<int[]>();
boolean[]  im;

int skelW = sW;
int skelH = sH;
PGraphics skelPg;
int threshold = 128; // 128;
int skelVal = 10; // 10;
int skipPoints = 1;
int minStrokePoints = 4;

void skeletonSetup() {
  im = new boolean[skelW * skelH];
  
  skelPg = createGraphics(skelW, skelH, P2D);
  skelPg.beginDraw();
  skelPg.background(0);
  skelPg.endDraw();
  skelPg.loadPixels();
}
void skeletonDraw() { 
  xyScopeBegin();

  skelPg.beginDraw();
  skelPg.image(frame, 0, 0, skelPg.width, skelPg.height);
  skelPg.endDraw();
  
  for (int i = 0; i < im.length; i++) {
    skelPg.pixels[i] = abs(255 - frame.pixels[i]);
    im[i] = (skelPg.pixels[i]>>16&0xFF) > threshold;
  }
  
  TraceSkeleton.thinningZS(im, skelW, skelH);

  rects.clear();
  c = TraceSkeleton.traceSkeleton(im, skelW, skelH, 0, 0, skelW, skelH, skelVal, 999, rects);
  
  for (int i = 0; i < c.size(); i++) {    
    if (c.get(i).size() >= minStrokePoints) {
      stroke(127 + random(127), 127 + random(127), 127 + random(127));
      noFill();
  
      beginShape();
      xy.beginShape();
      
      for (int j = 0; j < c.get(i).size(); j+=skipPoints) {
        float x1 = c.get(i).get(j)[0];
        float y1 = c.get(i).get(j)[1];
        vertex(x1, y1);
        xy.vertex(x1, y1);
        
        //xy.point(x1, y1);
        
        /*
        if (j > 0) {
          float x2 = c.get(i).get(j-1)[0];
          float y2 = c.get(i).get(j-1)[1];
          xy.line(x1, y1, x2, y2);
        }
        */
        
        totalPointsCounter++;
      }
      
      endShape();   
      xy.endShape();
    }
  }
  
  xyScopeEnd();
}

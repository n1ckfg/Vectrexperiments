import java.io.*;
import java.lang.reflect.*;
import java.lang.*;
import java.awt.geom.AffineTransform;
import java.util.*;
import traceskeleton.*;

ArrayList<ArrayList<int[]>>  c;
ArrayList<int[]> rects = new ArrayList<int[]>();
boolean[]  im;

int skelW = 512;
int skelH = 512;
PGraphics skelPg;
boolean invert = true;
int threshold = 32; // 128;
int skelVal = 1; // 10;
int skipPoints = 2;

void skeletonSetup() {
  im = new boolean[skelW * skelH];
  
  skelPg = createGraphics(skelW, skelH, JAVA2D);
  skelPg.beginDraw();
  skelPg.background(0);
  skelPg.endDraw();
  skelPg.loadPixels();
}
void skeletonDraw() { 
  skelPg.beginDraw();
  skelPg.image(result, 0, 0);
  if (invert) skelPg.filter(INVERT);
  skelPg.endDraw();
  
  for (int i = 0; i < im.length; i++) {
    skelPg.pixels[i] = abs(255 - result.pixels[i]);
    im[i] = (skelPg.pixels[i]>>16&0xFF) > threshold;
  }
  
  TraceSkeleton.thinningZS(im, skelW, skelH);

  rects.clear();
  c = TraceSkeleton.traceSkeleton(im, skelW, skelH, 0, 0, skelW, skelH, skelVal, 999, rects);
  
  for (int i = 0; i < c.size(); i++) {    
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

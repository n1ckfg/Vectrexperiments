import gab.opencv.*;

OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Brushstroke> brushstrokes;
int maxBsLength = 100;
int skipPoints = 25;
int contourReps = 3;

void contourSetup() {
  opencv = new OpenCV(this, frame);
  brushstrokes = new ArrayList<Brushstroke>();
}

void contourUpdate() {
  for (int i=0; i<255; i+= int(255/contourReps)) {
    opencv.loadImage(frame);
    opencv.gray();
    opencv.threshold(i);
    contours = opencv.findContours();
 
    if (contours != null) {
      for (Contour contour : contours) {
        Brushstroke bs = new Brushstroke();
        ArrayList<PVector> points = contour.getPoints();
        if (points.size() > 10) {
          for (int j=0; j<points.size(); j+= skipPoints) {
            PVector p = points.get(j);
            bs.points.add(p);
          }
          
          brushstrokes.add(bs);
          while (brushstrokes.size() > maxBsLength) brushstrokes.remove(0);
        }
      }
    }
  }
}

void contourDraw() {
  noFill();
  stroke(255);
  strokeWeight(1);
  for (Brushstroke bs : brushstrokes) {
    beginShape();
    xy.beginShape();
    for (PVector point : bs.points) {
      vertex(point.x, point.y);
      xy.vertex(point.x, point.y);
    }
    endShape();
    xy.endShape();
  }  
}

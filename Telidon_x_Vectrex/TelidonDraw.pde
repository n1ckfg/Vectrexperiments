// 5. Drawing class--this is where it all comes together.
// Processing-specific drawing code is separated here.
class TelidonDraw {
  
  NapDecoder decoder;
  ArrayList<TelidonDrawCmd> drawCmds;
  int counter = 0;
  
  TelidonDraw(String _filePath) {
    decoder = new NapDecoder(loadStrings(_filePath));
    drawCmds = new ArrayList<TelidonDrawCmd>();
    
    for(int i=0; i<decoder.cmds.size(); i++) {
      NapCmd cmd = decoder.cmds.get(i);
      if (cmd.opcode.id.equals("SET & POLY FILLED")) {
        drawCmds.add(new TelidonDrawCmd(cmd));
        for (int j=0; j<cmd.points.size(); j++) {
          println(j + ". " + cmd.points.get(j));
        }
      }
    }
  }
  
  void draw() {
    background(0);
    counter = 0;
    for (int i=0; i<drawCmds.size(); i++) {
      TelidonDrawCmd drawCmd = drawCmds.get(i);
      if (!drawCmd.moveScanline) counter++;
      if (i == counter || !drawCmd.moveScanline) {
        drawCmd.run();
      }
    }    
  }

}

class TelidonDrawCmd {

  NapCmd cmd;
  PGraphics tex;
  float scanPos = height;
  float scanDelta = 80;
  boolean moveScanline = true;
  boolean labelPoints = true;
  
  int skipPoints = 1; // Vectrex is limited in how many points it can draw per frame

  TelidonDrawCmd(NapCmd _cmd) {
    cmd = _cmd;
    tex = createGraphics(width, height, P2D);
  }
  
  void update() {
    if (moveScanline) {
      scanPos -= scanDelta;
      if (scanPos <= 0) moveScanline = false;
    }
  }
  
  void draw() {
    if (moveScanline) {
      tex.beginDraw();
      drawPoints(cmd.points, width, height);
      tex.endDraw();
    
      /*
      if (moveScanline) {
        tex.loadPixels();
        for (int x=0; x < tex.width; x++) {
          for (int y=0; y < tex.height; y++) {
            int loc = x + y*tex.width;
            if (y <= scanPos) tex.pixels[loc] = color(0,0);
          }
        }
        tex.updatePixels();
      }
      */
    
      image(tex.get(0, int(scanPos), tex.width, tex.height), 0, scanPos);
    } else {
      image(tex, 0, 0);
    }
  }
  
  void run() {
    update();
    draw();
  }
  
  void drawPoints(ArrayList<PVector> points, int w, int h) {
    tex.noFill();
    tex.stroke(0,255,50,15);
    tex.strokeWeight(2);
    tex.beginShape();
    for (int i=0; i<points.size(); i+=skipPoints) {
      PVector p = points.get(i);
      tex.vertex(p.x * w, p.y * h);
      xy.point(p.x * w, p.y * h);
    }
    tex.endShape(CLOSE);
    
    if (labelPoints) {
      tex.strokeWeight(4);
      for (int i=0; i<points.size(); i+=skipPoints) {
        tex.stroke(50, 255, 50, 15);
        PVector p = points.get(i);
        tex.point(p.x * w, p.y * h);
  
        //tex.textFont(font, fontSize);
        //tex.fill(0);
        //tex.text(i, (p.x * w) + 2, (p.y * h) + 2);
        //tex.fill(255);
        //tex.text(i, p.x * w, p.y * h);
      }
    }
  }
  
}

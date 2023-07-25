// 3. Command class
// Assembles one drawing command from its opcode and data bytes.

class NapCmd {
  
  // TODO draw each command to its own PGraphics buffer.
  String cmdRaw;
  int index;
  NapOpcode opcode;
  ArrayList<NapData> data;
  ArrayList<PVector> points;
  int pointBytes = 4; // TODO set programatically from header info
  boolean pointRelative = true;  // TODO set programatically from header info

  NapCmd(String _cmd, int _index) {
    cmdRaw = _cmd;
    index = _index;
    data = new ArrayList<NapData>();
    points = new ArrayList<PVector>();
    
    opcode = new NapOpcode(cmdRaw.charAt(0));
    if (cmdRaw.length() > 1) {
      for (int i=1; i<cmdRaw.length(); i++) {
        data.add(new NapData(cmdRaw.charAt(i)));
      }
    }
    
    // This is where we find out what kind of command it is
    // Which tells us how we handle the data
    switch(opcode.id) {
      case("SET & POLY FILLED"): // relative points after first 
        getPoints();
        break;
      default:
        break;
    }
  }
   
  void printCmd(String mode) {
    println(formatCmd(mode));
  }
  
  // This prints out the command contents in various formats
  // Helpful for debugging
  String formatCmd(String mode) {
    String returns = "(" + index + ") " + opcode.id;
    if (data.size() > 0) returns += ": ";
    if (opcode.id.equals("")) {
      switch(mode) {
        case("char"):
          returns += opcode.c;
          break;
        case("binary"):
          returns += opcode.binary;
          break;
         case("rbinary"):
          returns += opcode.rbinary;
          break;  
        case("ascii"):
          returns += opcode.ascii;
          break;
        case("hex"):
          returns += opcode.hex;
          break;
        default:
          break;
      }
    }
    if (data.size() > 0) {
      if (opcode.id.equals("")) returns += ", ";
      for (int i=0; i<data.size(); i++) {
        switch(mode) {
          case("char"):
            returns += "" + data.get(i).c;
            break;
          case("binary"):
            returns += "" + data.get(i).binary;
            break;
          case("rbinary"):
            returns += "" + data.get(i).rbinary;
            break;
          case("ascii"):
            returns += "" + data.get(i).ascii;
            break;
          case("hex"):
            returns += "" + data.get(i).hex;
            break;
          default:
            break;
        }
        if (i < data.size() - 1) returns += ", ";
      }
    }
    return returns;
  }
  
  // ~ ~ ~ Parsing methods begin here ~ ~ ~
  void getPoints() {
    ArrayList<NapVector> nvList = new ArrayList<NapVector>();
    for (int i=0; i<data.size(); i+=pointBytes) {
      ArrayList<NapData> n = new ArrayList<NapData>();
      for (int j=0; j<pointBytes; j++) {
        n.add(data.get(i + j));
      }
      nvList.add(new NapVector(n));
    }
    
    for (int i=0; i<nvList.size(); i++) {
      NapVector nv = nvList.get(i);

      if (pointRelative) {
        if (i==0) {
          points.add(new PVector(nv.x, nv.y));
        } else {
          PVector p = points.get(points.size()-1);
          
          float x = 0;     
          if (nv.x < 0) {
            x = (abs(nv.x) + abs(p.x)) - 1.0;
          } else {
            x = nv.x + p.x;
          }
          
          float y = 0;
          if (nv.y < 0) {
            y = abs(nv.y) + p.y;
          } else {
            y = (abs(nv.y) + abs(p.y)) - 1.0;
          }
          
          points.add(new PVector(x, y));
        }
      } else {
        points.add(new PVector(nv.x, nv.y));
      }
      // * * * * * 
    }
  }
  
  void getDomain() {
    for (int i=0; i<data.size(); i++) {
      // TODO parse header info, most importantly:
      // How many bytes per point
      // XY format (3 bits per axis per byte) or XYZ format (2 bits per axis per byte)
      // How many bytes per color
      // Color format?
    }
  }
  
}
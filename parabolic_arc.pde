
// Global objects
ParabolicArc arc;
Slider slider;
WireCheckBox wireCheckBox;
GuideLineCheckBox guideLineCheckBox;


// program entry
void setup() {
 size(640, 360);
 colorMode(RGB);
 
 arc = new ParabolicArc();
 slider = new Slider(25, 360 - 100, 100);
 wireCheckBox = new WireCheckBox(25, 360 - 65);
 guideLineCheckBox = new GuideLineCheckBox(25, 360 - 35);
}

// draw loop
void draw() {
  background(44, 62, 80);    // a nice shade of midnight blue
  arc.render();
  slider.render();
  wireCheckBox.render();
  guideLineCheckBox.render();
}

// mouse handlers
void mousePressed() {
  arc.checkBounds();
  slider.checkBounds();
  wireCheckBox.checkBounds();
  guideLineCheckBox.checkBounds();
}
void mouseDragged() {
  arc.drag();
  slider.drag();
}
void mouseReleased() {
 arc.undrag();
 slider.undrag();
}


//// A parabolic arc composed of three points.
//// Main object of this demo
class ParabolicArc {
 
  Point a;
  Point b;
  Point c;
  
  Point selected;
  
  ParabolicArc() {
    a = new Point(50, 50);
    b = new Point(300, 50);
    c = new Point(300, 200);
  }
  
  void render() {
    // render guide lines, a->b, b->c
    if (wireCheckBox.checked) {
      stroke(52, 152, 219);
      strokeWeight(2);
      line(a.x, a.y, b.x, b.y);
      line(b.x, b.y, c.x, c.y);
    }
    
    // render parabolic arc
    stroke(46, 204, 113);
    float firstX = a.x;        // start from the first point
    float firstY = a.y;
    
    float inc = 1.0 / float(slider.lines);        // the amt to increment each iteration, depending on the number of lines from the slider
    for (float i = 0.0; i < 1; i += inc) {
       float qx = ((1.0 - i) * a.x) + (i * b.x);
       float qy = ((1.0 - i) * a.y) + (i * b.y);
       float rx = ((1.0 - i) * b.x) + (i * c.x);
       float ry = ((1.0 - i) * b.y) + (i * c.y);
       
       float px = ((1.0 - i) * qx) + (i * rx);
       float py = ((1.0 - i) * qy) + (i * ry);
       
       // if guideline checkbox is checked, show the guideline
       if (guideLineCheckBox.checked && i != 0) {
         strokeWeight(1);
         line(qx, qy, rx, ry);
       }
       // draw the continuation of the arc
       strokeWeight(4);
       line(firstX, firstY, px, py);
       firstX = px;
       firstY = py;
    }
    line(firstX, firstY, c.x, c.y);      // connect to the last point
    
    // render points
    a.render();
    b.render();
    c.render();
  }
  
  void checkBounds() {
    // check if the mouse is pressed on any points
    if (a.checkBounds()) { this.selected = a; }
    else if (b.checkBounds()) { this.selected = b; }
    else if (c.checkBounds()) { this.selected = c; }
  }
  
  void drag() {
   if (this.selected != null) {
    this.selected.x = mouseX;
    this.selected.y = mouseY;
   }
  }
  
  void undrag() {
   this.selected = null; 
  }
  
}


//// Draws a yellow 15x15 point
class Point {
 
  public float x;
  public float y;
  public float width;
  public float height;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
    this.width = 15;
    this.height = 15;    
  }
  
  void render() {
   stroke(241, 196, 15);
   fill(241, 196, 15);
   ellipse(this.x, this.y, this.width, this.height);
  }
  
  boolean checkBounds() {
    float left = this.x - (this.width / 2.0);
    float top = this.y - (this.height / 2.0);
    float right = this.x + (this.width / 2.0);
    float bottom = this.y + (this.height / 2.0);
    
    if (mouseX > left && mouseX < right && mouseY > top && mouseY < bottom) {
      return true;
    }
    return false;
  }
  
}
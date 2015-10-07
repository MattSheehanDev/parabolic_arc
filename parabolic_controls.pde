
//// Slider control,
//// renders in the bottom left corner with all other controls.
//// The slider controls the precision of the arc.
class Slider {
 
  /// internal slider nub class,
  /// draws the little nub that is used for dragging
  class Nub {
    
    float x, y, parentHeight, size;
    
    Nub(float x, float y, float parentHeight) {
      this.x = x;
      this.y = y;
      this.parentHeight = parentHeight;
      this.size = 20;
    }
    
    void render() {
      //float nubx = x + (this.size / 2);
      float nuby = y + (this.parentHeight / 2);
      stroke(155, 89, 182);
      fill(155, 89, 182);
      ellipse(this.x, nuby, this.size, this.size);
    }
    
  }
  
  
  float x, y, width, height;
  int lines;
  Nub nub;
  boolean selected;
  
  Slider(float x, float y, float width) {
    this.x = x;
    this.y = y + 10;
    this.width = width;
    this.height = 10;
    
    this.nub = new Nub(this.x, this.y, this.height);
    this.selected = false;
  }
  
  void render() {
    lines = int(((this.nub.x - this.x) * 100) / this.width);
    
    strokeWeight(1);
    stroke(255);
    fill(255);
    text("Number of lines: " + lines, this.x, this.y - 10);
    
    stroke(236, 240, 241);
    fill(236, 240, 241);
    rectMode(CORNERS);
    rect(this.x, this.y, this.x + this.width, this.y + this.height);
    
    this.nub.render();
  }
  
  void checkBounds() {
    // ellipses draw in the center,
    // so determine the boundary of the ellipse using the radius
    float radius = this.nub.size / 2;
    float left = this.nub.x - radius;
    float right = this.nub.x + radius;
    float top = this.nub.y - radius;
    float bottom = this.nub.y + radius;
    
    if (mouseX >= left && mouseX <= right && mouseY >= top && mouseY <= bottom) {
      this.selected = true;
    }
  }
  
  void drag() {
    if (this.selected) {
      if (mouseX >= this.x && mouseX <= this.x + this.width) {
        this.nub.x = mouseX; 
      }
    }
  }
  
  void undrag() {
    this.selected = false; 
  }
  
}



//// Wire Checkbox,
//// renders below the slider, initially checked.
//// Toggles the wire lines (the lines from points A,B and B,C) being drawn or not drawn
class WireCheckBox {
 
  float x, y;
  boolean checked;
  
  WireCheckBox(float x, float y) {
    this.x = x;
    this.y = y;
    this.checked = true;
  }
  
  void render() {
    rectMode(CORNERS);
    stroke(236, 240, 241);
    fill(236, 240, 241);
    rect(this.x, this.y, this.x + 10, this.y + 10);
    
    // if checked, signal it with an X across the box
    if (this.checked) {
      stroke(0);
      line(this.x, this.y, this.x + 10, this.y + 10);
      line(this.x, this.y + 10, this.x + 10, this.y);
    }
    
    stroke(255);
    fill(255);
    strokeWeight(1);
    text("Toggle skeleton lines", this.x + 15, this.y + 10);
  }
  
  void checkBounds() {
    if (mouseX > this.x && mouseX < this.x + 10 && mouseY > this.y && mouseY < this.y + 10) {
      this.checked = this.checked ? false : true;
    }
  }
  
}


//// Guideline checkbox,
//// renders below the render checkbox, initially unchecked.
//// Toggles the guidelines (the lines that intersect with the parabola) being drawn or not drawn
class GuideLineCheckBox {
 
  float x, y;
  boolean checked;
  
  GuideLineCheckBox(float x, float y) {
    this.x = x;
    this.y = y;
    this.checked = false;
  }
  
  // render and checkbounds functions are duplicated between WireCheckBox and GuideLineCheckBox
  void render() {
    rectMode(CORNERS);
    stroke(236, 240, 241);
    fill(236, 240, 241);
    rect(this.x, this.y, this.x + 10, this.y + 10);
    
    if (this.checked) {
      stroke(0);
      line(this.x, this.y, this.x + 10, this.y + 10);
      line(this.x, this.y + 10, this.x + 10, this.y);
    }
    
    stroke(255);
    fill(255);
    strokeWeight(1);
    text("Toggle guide lines", this.x + 15, this.y + 10);
  }
  
  void checkBounds() {
    if (mouseX > this.x && mouseX < this.x + 10 && mouseY > this.y && mouseY < this.y + 10) {
      this.checked = this.checked ? false : true;
    }
  }
  
}
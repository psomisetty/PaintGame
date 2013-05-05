class Circle{
  PVector location;
  float diax;
  float diay;
  color c;
  
  Circle(float x, float y, float _diax, float _diay, color _c){
    location = new PVector(x,y);
    diax = _diax; // X Width
    diay = _diay; // Y height
    c = _c; // Color
  }
  
  void render(){
    // Draws object at specified location with specified color using transformations
    fill(c);
    pushMatrix();
      translate(location.x,location.y);
      noStroke();
      fill(c);
      ellipse(0,0,diax,diay);
    popMatrix();
  }
  
  boolean part_out_of_screen(){
    // Returns if object is partially out of screen
    if (location.x + diax/2 > width){
      return (true);
    } else if (location.x - diax/2 < 0){
      return (true);
    } else if (location.y + diay/2 > height){
      return (true);
    } else if (location.y - diay/2 < 0){
      return (true);
    } else {
    return (false);
    }
  }
}

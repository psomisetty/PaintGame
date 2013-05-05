class Rectangle{
  PVector location;
  float wid;
  float het;
  float ang;
  color c;
  
  Rectangle(float x, float y, float _width, float _height, float _ang, color _c){
    location = new PVector(x,y);
    wid = _width; // Width
    het = _height; // Height
    ang = _ang; // Rotation Angle ( for future development of dealing with rotating objects )
    c = _c; // Color
  }
  
  void render(){
    pushMatrix();
      translate(location.x,location.y);
      rotate(ang);
      noStroke();
      fill(c);
      rect(0,0,wid,het);
    popMatrix();
  }
  
  boolean part_out_of_screen(){
    //Checks if part of object is out of screen
    if (location.x + wid > width){
      return (true);
    } else if (location.x < 0){
      return (true);
    } else if (location.y + het > height){
      return (true);
    } else if (location.y < 0){
      return (true);
    } else {
    return (false);
    }
  }
}

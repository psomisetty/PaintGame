class Wall extends Rectangle{
  float rs;
  float ls;
  float tp;
  float bt;
  
  Wall(float _x, float _y, float _width, float _height, float _ang, color _c){
    super( _x,  _y,  _width,  _height,  _ang,  _c);
    ls = _x; // Sets left side
    tp = _y; // Sets top
    rs = _x + _width; // Sets Right Side
    bt = _y + _height; // Sets Bottom
  }
  /*
  Parent wall class that stores the object's general specifications such as side positions
  */
}

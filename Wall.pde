class Wall extends Rectangle{
  float rs;
  float ls;
  float tp;
  float bt;
  
  Wall(float _x, float _y, float _width, float _height, float _ang, color _c){
    super( _x,  _y,  _width,  _height,  _ang,  _c);
    ls = _x;
    tp = _y;
    rs = _x + _width;
    bt = _y + _height;  
  }
  /*
  Parent wall class that stores the object's general specifications such as side positions
  */
}

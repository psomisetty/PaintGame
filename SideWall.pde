class SideWall extends Wall{
  SideWall(float _x, float _y, float _width, float _height, float _ang, color _c){
  super( _x,  _y,  _width,  _height,  _ang,  _c);
  }
  /*
  Class exists for future development, in case SideWall has different properties than floor wall
    such as bouncy, runny paint, climbable, etc.
  */
}

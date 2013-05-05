class Paint extends Circle{
  PVector velocity;
  float mass;
  
  Paint(float x, float y, color _c, float r, float _mass){
    super(x,y,30,30,_c); // Passes location, size, and color to super class
    velocity = new PVector(cos(radians(r)),sin(radians(r))); // Initializes unit vector of velocity in direction of rotation
    velocity.normalize(); // Ensures vector is unit vector
    velocity.mult(10); // Sets magnitude of vector to 10
    mass = _mass; // Sets mass (for future force field applications)
  }

  void run(ArrayList<Wall> Walls, PVector gravity, PVector Force){
    ArrayList collides = collides_wall(Walls);
    if ((Boolean) collides.get(0) == true){ // If collides is true
      render_splatter((Wall)collides.get(1),(Float) collides.get(2)); // Renders "paint splatter" when paint hits wall or floor using Wall object and float position
    } else if ((Boolean) collides.get(0) == false) { // No collision exists
      super.render(); // Renders ordinary paint
      applyAccel(gravity); // Accelerates paint's velocity
      applyForce(Force); // Applies force to object (if available)
      step(); // adds velocity to location
    }
  }
  
  //Functions that deal with collision

  ArrayList collides_wall(ArrayList<Wall> Walls){
   ArrayList result = new ArrayList(); // creates empty array list
   boolean b = false; // initializes failure
   for (Wall w: Walls){
      if (w instanceof SideWall){
        if ((location.x + 15 > w.ls && location.x - 15 > w.rs) || (location.x + 15 < w.ls && location.x - 15 < w.rs)){ // Creates an XOR boolean comparison. makes sure paint is beyond bounds.
          b = true; // Collision is true
          result.add(b); // Add boolean
          result.add(w); // Add wall object
          result.add(w.location.x); // Add wall's x position
        } else {
          result.add(b); // Collision is false
        }
      } else if (w instanceof FloorWall){
        if (location.y > w.tp){
          b = true; // Collision is true
          result.add(b); // Add boolean
          result.add(w); // Add wall object
          result.add(w.location.y); // Add wall's y postion
        } else {
          result.add(b); // Collision is false
        }
      } else {
        result.add(b); // Compared object is not a Wall
      }
    }
   return result;
  }
  
  void render_splatter(Wall w, float loc){
    if ( w instanceof SideWall ){
      location.x = loc;
      pushMatrix();
        translate(location.x,location.y);
        fill(c);
        rect(0,0,w.wid, 30 + abs(velocity.y));
      popMatrix();
    } else if ( w instanceof FloorWall ) {
      location.y = loc;
      pushMatrix();
        translate(location.x,location.y);
        fill(c);
        rect(location.x-15 , 0, 30, w.het);
      popMatrix();
    }
  }
  
  //Functions that deal with movement  
  
  void step(){
    location.add(velocity); // Adds velocity to location
  }
  
  void applyAccel(PVector acceleration){
    velocity.add(acceleration); // Adds acceleration to velocity
  }
  
  void applyForce(PVector Force){
    applyAccel(new PVector(Force.x/mass, Force.y/mass)); // Converts Force into acceleration by dividing by mass. EQUATION: Force = mass * acceleration
  }
}

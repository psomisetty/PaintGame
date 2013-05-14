class Paint extends Circle{
  PVector velocity;
  float mass;
  
  Paint(float x, float y, color _c, float r, float _mass){
    super(x,y,30,30,_c); // Passes location, size, and color to super class
    velocity = new PVector(cos(radians(r)),sin(radians(r))); // Initializes unit vector of velocity in direction of rotation
    velocity.normalize(); // Ensures vector is unit vector
    velocity.mult(15); // Sets magnitude of vector to 15
    mass = _mass; // Sets mass (for future force field applications)
  }

  void run(ArrayList<Wall> Walls, PVector gravity, PVector Force){
    ArrayList collides = collides_wall(Walls); // Get the ArrayList of Values
    boolean colliding = (Boolean) collides.get(0); // Get the Boolean Value
    if (colliding){ // If collides is true
      render_splatter((Wall)collides.get(1),(Float) collides.get(2)); // Renders "paint splatter" when paint hits wall or floor using Wall object and float position
    } else { // No collision exists
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
   Wall wall = null;
   float loc = 0;
   for (Wall w: Walls){
      if (w instanceof SideWall){
        if ((w.ls <= location.x) && (location.x <= w.rs)){
          b = true; // Collision is true
          wall = w; // Add wall
          loc = w.location.x; // Add wall's x position
          break;
        }
      } else if (w instanceof FloorWall){
        if (location.y >= w.tp){
          b = true; // Collision is true
          wall = w; // Add wall
          loc = w.location.y; // Add wall's y position
          break;
        }
      }
    }
  result.add(b);
  result.add(wall);
  result.add(loc);
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
        rect(-15 , 0, 30, w.het);
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

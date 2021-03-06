class Player{
  PVector location;
  PVector velocity;
  float lx_bound;
  float rx_bound;
  float by_bound;
  float angle;
  float mass;
  boolean can_jump;
  ArrayList<Paint> paintblobs;
  Boolean[] motions;
  Sprite sprite;
  int direction;
  int animationSpeed;
  int updateCount;
  boolean moving;
  int index;
  
  Player(float x, float y, float _lx_bound, float _rx_bound, float _by_bound){
    /*
    Creates a player character and sets a left bound, a right bound and a bottom bound, in that order.
      Then sets the starting location, and initializes an Arraylist to contain Paint objects. Then
      sets the starting trajectory angle to be -90 degrees, straight up.
    */
    lx_bound = _lx_bound; // Left bound
    rx_bound = _rx_bound; // Right bound
    by_bound = _by_bound; // Bottom bound
    location = new PVector(x,y); // Starting Location
    velocity = new PVector(0,0); // No speed
    paintblobs = new ArrayList(); // ArrayList of Paint objects
    angle = -90; // Starting angle, straight up
    mass = 1;
    can_jump = true;
    motions = new Boolean[4];
    for (int i = 0; i < 4; i++){
      motions[i] = false;
    } // Populate all motion to be false
    sprite = new Sprite("daxbotsheet_0.png",4,4);
    direction = 0; // Set direction to left 0, right 1
    animationSpeed = 10;
    updateCount = 0;
    index = 0;
  }
  
  void run(ArrayList<Wall> walls, PVector gravity, PVector Force){
    drawangle(); // Draws the trajectory line
//    drawchar(); // Draws the Character
    drawsprite();
    keyinter(); // Interprets keypress
    motions(); // Does the motions
    in_bound(); // Checks if object in bound
    for (Paint p: paintblobs){
      p.run(walls, gravity, Force); // Runs the paint blobs
    }
    if(can_jump == false){
      applyAcceleration(new PVector(0,1.5));
      applyVelocity();
    }
  }
  
  void jump(){
    velocity.y = -20;
  }

  void motions(){
    if (motions[0]){
      //Moves the location of the character to the left
      updateCount++;
      if (updateCount == animationSpeed){
        updateCount = 0;
        index++;
      }
      location.x -= 2;
    }
    if (motions[1]){
      //Moves the location of the character to the right
      updateCount++;
      if (updateCount == animationSpeed){
        updateCount = 0;
        index++;
      }
      location.x += 2;
    }
    if (motions[2]){
      if (angle >= -180){
        //Decrements angle of trajectory line by 1
        angle -= 1;
      }
    }
    if (motions[3]){
      if (angle <= 0){
        //Incrememnts angle of trajectory line by 1
        angle += 1;
      }
    }
    if (index == sprite.cols){
      index = 0;
    }
  }

  void keyinter(){
    if (keyPressed){
      if (key == CODED){
        if (keyCode == LEFT){
          //Sets Moving Left to true
          direction = 0; // Sets Direction to left
          moving = true;
          motions[0] = true;
        } else if (keyCode == RIGHT){
          //Sets Moving Right to true
          direction = 1; // Sets Direction to Right
          moving = true;
          motions[1] = true;
        } else if (keyCode == UP){
          if (angle >= -180){
            //Sets Decrement Angle to true
            motions[2] = true;
          }
        } else if (keyCode == DOWN){
          if (angle <= 0){
            //Sets Increment Angle to true
            motions[3] = true;
          }
        }
      } else if (key == 'c' || key == 'C'){
          if(can_jump){
            jump();
            can_jump = false;
          }
      }
    }
  }
  
  void in_bound(){
    if (location.x - 10 < lx_bound){
      location.x += 3; // Sets the x component of location to the left bound if exceeded
    } else if (location.x + 10 > rx_bound){
      location.x -= 3; // Sets the x component of location to the right bound if exceeded
    } else if (location.y > by_bound){
      location.y = by_bound; // Sets the y component of location to the bottom bound if exceeded
      velocity.y = 0; // Sets vertical Velocity to 0
      can_jump = true;
    }
  }
  
  void applyForce(PVector force){ // Force Function exists for future development, in case wind or friction exists in future
    force.div(mass);
    velocity.add(force);
  }
  
  void applyAcceleration(PVector acceleration){
    velocity.add(acceleration);
  }
  
  void applyVelocity(){
    location.add(velocity);
  }
  
  void drawsprite(){
    pushMatrix();
      translate(location.x-sprite.spriteWidth/2,location.y-sprite.spriteHeight);
      if (direction == 0){
        image(getReversePImage(sprite.spriteAnimationArray[index]),0,0);
      } else if (direction == 1){
        image(sprite.spriteAnimationArray[index],0,0);
      }
    popMatrix();
  }

  PImage getReversePImage( PImage myimage ){
    PImage reverse = new PImage( myimage.width, myimage.height );
    for( int i=0; i < myimage.width; i++ ){
      for(int j=0; j < myimage.height; j++){
        reverse.set( myimage.width - 1 - i, j, myimage.get(i, j) );
      }
    }
    return reverse;
  }

  void drawchar(){
    //Draws the character by translating the grid to the location and rotating it 180 degrees
    pushMatrix();
      translate(location.x,location.y); // Move to location
      noStroke();
      rotate(PI); // Rotate 180 degrees
      fill(128); // Set Gray
      rect(-10,0,20,50); // Centers and creates rectangle "Upside Down"
    popMatrix();
  }
  
  void drawangle(){
    // Draws the Trajectory line
    pushMatrix();
      translate(location.x,location.y - 50); // Move to location
      rotate(radians(angle)); // Rotate to angle
      strokeWeight(4);
      stroke(128, 0, 32); // Set Color
      line(0,0,40,0); // Draw a line of length 40
    popMatrix();
  }
}

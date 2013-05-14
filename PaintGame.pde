Player p;
ArrayList<Wall> walls;
PVector gravity;

void setup(){
  size(400,400);
  background(0);
  p = new Player(width/2, height-30, 50, width-50, height-30);
  walls = new ArrayList(); // Initialze ArrayList
  walls.add(new FloorWall(0, height-30, width, 30, 0, color(255))); // Create Floor
  walls.add(new SideWall(0, 0, 30, height, 0, color(255))); // Create left wall
  walls.add(new SideWall(width-30, 0 , 30, height, 0, color(255))); // Create Right Wall
  gravity = new PVector(0,.5); // Set acceleration due to gravity
}

void draw(){
  background(0);
  for (Wall w: walls){
    w.render(); // Draw walls
  }
  p.run(walls,gravity,new PVector(0,0)); // Draw Character and all paint objects
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == SHIFT){
      p.paintblobs.add(new Paint(p.location.x, p.location.y - 50, color(int(random(255)),int(random(255)),int(random(255))), p.angle, 1));
    }
  }
}

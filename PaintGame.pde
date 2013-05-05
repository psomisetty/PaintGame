Player p;
ArrayList<Wall> walls;
PVector gravity;

void setup(){
  size(400,400);
  background(0);
  p = new Player(width/2, height-30, 50, width-50, height-30);
  walls = new ArrayList();
  walls.add(new FloorWall(0, height-30, width, 30, 0, color(255)));
  walls.add(new SideWall(0, 0, 30, height, 0, color(255)));
  walls.add(new SideWall(width-30, 0 , 30, height, 0, color(255)));
  gravity = new PVector(0,3);
}

void draw(){
  background(0);
  for (Wall w: walls){
    w.render();
  }
  p.run(walls,gravity,new PVector(0,0));
}

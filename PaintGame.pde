import ddf.minim.*;

Minim minim;
AudioPlayer player;
Player p;
ArrayList<Wall> walls;
PVector gravity;
float v_mult;

void setup(){
  size(600,600);
  background(0);
  p = new Player(width/2, height-30, 50, width-50, height-30);
  walls = new ArrayList(); // Initialze ArrayList
  walls.add(new FloorWall(0, height-30, width, 30, 0, color(255))); // Create Floor
  walls.add(new CeilingWall(0, 0, width, 30, 0, color(255))); // Create Ceiling
  walls.add(new SideWall(0, 0, 30, height, 0, color(255))); // Create Left Wall
  walls.add(new SideWall(width-30, 0 , 30, height, 0, color(255))); // Create Right Wall
  gravity = new PVector(0,.5); // Set acceleration due to gravity
  
  // Audio Files
  minim = new Minim(this); // Initialize new minim
  player = minim.loadFile("IncompatibleType.mp3",2048); // Create new AudioPlayer with buffer size 2048
  player.loop(); // Loop Song Forever
}

void draw(){
  background(0);
  for (Wall w: walls){
    w.render(); // Draw walls
  }
  for(int i = 0; i < player.bufferSize() - 1; i++){
    v_mult = abs(player.left.get(i)*player.right.get(i))*500+10; // Set Magnitude of Velocity for paint objects based on intensity of song
    if (v_mult > 30){
      v_mult = 30; // limit speed to 30;
    }
  }
  p.run(walls,gravity,new PVector(0,0)); // Draw Character and all paint objects
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == SHIFT){
      color c = color(int(random(255)),int(random(255)),int(random(255)));
      p.paintblobs.add(new Paint(p.location.x, p.location.y - 50, c, p.angle, 1, v_mult)); // Create paint at Player Object
    }
  }
}

void stop(){
  player.close();
  minim.stop();
  
  super.stop();
}

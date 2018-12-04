Vehicle[] vehicles;
PImage front;
PImage back;
PImage sunset;

void setup() {
  size(3264, 2448, P3D);
  
 //front = loadImage("lanighttranspk.png");
  //back = loadImage("lanightback.jpg");
  sunset = loadImage("sunset.jpg");

  vehicles = new Vehicle[8600];

    for (int i = 0; i < vehicles.length; i++) {
      PVector v = random3D();
      v.mult(300);

    vehicles[i] = new Vehicle(v.x  , v.y , v.z);
    }
  
  
}


void draw() {

  //background(0);
  /*
  pushMatrix();
  translate(0, 0, -150);
  image(back,  0, 0, back.width/2, back.height/2);
  popMatrix();

  
    pushMatrix();
  translate(0, 0, 200);
  image(front,  0, 0, front.width/2, front.height/2);
    popMatrix();
  */
  image(sunset, 0, 0, sunset.width/2, sunset.height/2);

      for (int i = 0; i < vehicles.length; i++) {
  vehicles[i].boundaries();
  vehicles[i].update();
  vehicles[i].arrive(new PVector (mouseX, mouseY, sin(frameCount)*10));
  vehicles[i].display();


      }
  
}


PVector random3D() {
  float angle = random(0,TWO_PI);
  float vz    = random(-1,1);
  float vx = sqrt(1-vz*vz)*cos(angle);
  float vy = sqrt(1-vz*vz)*sin(angle);
  PVector  v = new PVector(vx, vy, vz);
  return v;
}
  
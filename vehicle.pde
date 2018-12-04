
class Vehicle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  float pulse = .01;
  
  Vehicle (float x, float y, float z ) {
    
    acceleration = new PVector (0, 0, 0);
    velocity = new PVector (0, 0, 0);
    location = new PVector (x, y, z);
    r = 3.0;
    maxspeed = random(1.5, 3.5);
    maxforce = random(.03, .06);
  }
  
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  /*
  void seek (PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  */
  
  void arrive (PVector target) {
        
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();
    if (d < 300) {
      float m = map(d, 0, 100, -50, maxspeed);
      desired.mult(m);
    } else {
      desired.mult(maxspeed);
    }
    

    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }



  void boundaries() {
   float d = 100;
    PVector desired = null;

    if (location.x < d) {
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (location.x > width -d) {
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (location.y < d) {
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > height-d) {
      desired = new PVector(velocity.x, -maxspeed);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }  



  
  
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(random(50, 100), 11, 44, location.y/4);
    noStroke();
    //stroke(0);
    pushMatrix();
    translate(location.x, location.y, location.z);
    rotate(theta);
    rotateY(theta);

    beginShape();
    vertex(0, -r*2);
    vertex(-r+1, r);
    vertex(r-1, r);
    

    endShape(CLOSE);

    //ellipse(0, 0, 3, 3);
    popMatrix();
    pulse+=.01;
  }
}
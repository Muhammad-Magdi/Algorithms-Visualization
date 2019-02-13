import java.*;
int sides = 5;
float theta = (sides - 2) * PI / sides;
float lengthRatio = (float)Math.tan(theta/2);
float thetaRatio = (float)(Math.sin(PI-theta)/Math.sin(theta/2));

void setup(){
  size(600, 600);
  background(0);
  stroke(255);
  strokeWeight(3);
  frameRate(5);
}

void draw(){
  background(0);
  translate(width/2, height/2);
  //rotate(random(0, PI));
  go(width/lengthRatio - 7, 3);
}

void go(float len, int depth){
  if(len <= 5)  return;
  PVector p = new PVector(lengthRatio*len/2, 0);
  rotate((PI-theta)/2);
  //stroke(random(0, 256), random(0, 256), random(0, 256));
  for(int i = 0 ; i < sides ; ++i){
    pushMatrix();
    translate(p.x, p.y);
    line(0, -len/2, 0, len/2);
    popMatrix();
    rotate(PI-theta);
  }
  go(thetaRatio*lengthRatio*len/2, depth-1);
}

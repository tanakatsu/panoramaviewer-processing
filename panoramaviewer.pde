// cube
PImage pano_u;
PImage pano_d;
PImage pano_f;
PImage pano_b;
PImage pano_r;
PImage pano_l;
int cube_screen_size = 200;
int theta = 0;
int phi = 0;
int fov = 60;

void setup() {
  size(640, 360, P3D);
  noStroke();
  
  pano_u = loadImage("up.jpg");  
  pano_d = loadImage("down.jpg");  
  pano_f = loadImage("front.jpg");  
  pano_b = loadImage("back.jpg");  
  pano_r = loadImage("right.jpg");  
  pano_l = loadImage("left.jpg");    
}
 
void draw() {
  background(0);
  
  draw_cube();
  camera_control();  
}

void draw_cube()
{
  // front
  pushMatrix();
  translate(width / 2, height / 2, -cube_screen_size / 2);
  beginShape();
  texture(pano_f);
  vertex(-cube_screen_size / 2, -cube_screen_size / 2, 0, 0, 0);
  vertex(cube_screen_size / 2, -cube_screen_size / 2, 0, pano_f.width, 0);
  vertex(cube_screen_size / 2, cube_screen_size / 2, 0, pano_f.width, pano_f.height);
  vertex(-cube_screen_size / 2, cube_screen_size / 2, 0, 0, pano_f.height);
  endShape();
  popMatrix();
  
  // right
  pushMatrix();
  translate(width / 2 + cube_screen_size / 2, height / 2, 0);
  rotateY(-PI/2);
  beginShape();
  texture(pano_r);
  vertex(-cube_screen_size / 2, -cube_screen_size / 2, 0, 0, 0);
  vertex(cube_screen_size / 2, -cube_screen_size / 2, 0, pano_r.width, 0);
  vertex(cube_screen_size / 2, cube_screen_size / 2, 0, pano_r.width, pano_r.height);
  vertex(-cube_screen_size / 2, cube_screen_size / 2, 0, 0, pano_r.height);
  endShape();
  popMatrix();

  // left
  pushMatrix();
  translate(width / 2 - cube_screen_size / 2, height / 2, 0);
  rotateY(PI/2);
  beginShape();
  texture(pano_l);
  vertex(-cube_screen_size / 2, -cube_screen_size / 2, 0, 0, 0);
  vertex(cube_screen_size / 2, -cube_screen_size / 2, 0, pano_l.width, 0);
  vertex(cube_screen_size / 2, cube_screen_size / 2, 0, pano_l.width, pano_l.height);
  vertex(-cube_screen_size / 2, cube_screen_size / 2, 0, 0, pano_l.height);
  endShape();
  popMatrix();
  
  // down
  pushMatrix();
  translate(width / 2, height / 2 + cube_screen_size / 2, 0);
  rotateX(PI/2);
  beginShape();
  texture(pano_d);
  vertex(-cube_screen_size / 2, -cube_screen_size / 2, 0, 0, 0);
  vertex(cube_screen_size / 2, -cube_screen_size / 2, 0, pano_d.width, 0);
  vertex(cube_screen_size / 2, cube_screen_size / 2, 0, pano_d.width, pano_d.height);
  vertex(-cube_screen_size / 2, cube_screen_size / 2, 0, 0, pano_d.height);
  endShape();
  popMatrix();  
  
  // up
  pushMatrix();
  translate(width / 2, height / 2 - cube_screen_size / 2, 0);
  rotateX(-PI/2);
  beginShape();
  texture(pano_u);
  vertex(-cube_screen_size / 2, -cube_screen_size / 2, 0, 0, 0);
  vertex(cube_screen_size / 2, -cube_screen_size / 2, 0, pano_u.width, 0);
  vertex(cube_screen_size / 2, cube_screen_size / 2, 0, pano_u.width, pano_u.height);
  vertex(-cube_screen_size / 2, cube_screen_size / 2, 0, 0, pano_u.height);
  endShape();
  popMatrix();

  // back
  pushMatrix();
  translate(width / 2, height / 2, cube_screen_size / 2);
  rotateY(PI);
  beginShape();
  texture(pano_b);
  vertex(-cube_screen_size / 2, -cube_screen_size / 2, 0, 0, 0);
  vertex(cube_screen_size / 2, -cube_screen_size / 2, 0, pano_b.width, 0);
  vertex(cube_screen_size / 2, cube_screen_size / 2, 0, pano_b.width, pano_b.height);
  vertex(-cube_screen_size / 2, cube_screen_size / 2, 0, 0, pano_b.height);
  endShape();
  popMatrix();
}

void keyPressed() {
  if (key == CODED) { 
    if (keyCode == UP) { 
       phi -= 1;
    } else if (keyCode == DOWN) {
       phi += 1;
    } else if (keyCode == RIGHT) {
      theta += 1;
    } else if (keyCode == LEFT) {
      theta -= 1;
    }
  } else if (key == '+') {
    fov -= 1;
  } else if (key == '-') {
    fov += 1;
  } else if (key == 'r') {
    theta = 0;
    phi = 0;
    fov = 60;
  } 
  
//  println("theta=" + theta);
//  println("phi=" + phi);
//  println("fov=" + fov);
}

void camera_control()
{
  // pan, tilt
  float cx = width / 2 + (cube_screen_size / 2) * abs(cos(radians(phi))) * sin(radians(theta));
  float cy = height / 2 +  (cube_screen_size / 2) * sin(radians(phi));
  float cz = -cube_screen_size / 2 * abs(cos(radians(phi))) * cos(radians(theta)); 
  camera(width/2, height/2, 0, cx, cy, cz, 0, 1, 0);
  
  // zoom
  float fov_rad = radians(fov);
  float cameraZ = (height / 2.0) / tan(fov_rad/2.0);
  perspective(fov_rad, float(width) / float(height), cameraZ / 10.0, cameraZ * 10.0);
}

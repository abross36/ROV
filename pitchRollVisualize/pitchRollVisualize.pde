import processing.serial.*;

float pitch, roll;
float position;

Serial myPort;


void setup() {
  // draw the window
  size(400, 400, P3D);
  // calculate translate position for disk
  position = width/2;
  
  // list all the available serial ports
  println(Serial.list());
  
  // open whatever port is the one you are using
  myPort = new Serial(this, Serial.list()[1], 115200);
  // only generate a serial event when you get a newline
  myPort.bufferUntil('\n');
  // enable smoothing for 3D
  smooth(4);
}

void draw() {
  // colors inspired by the amazon rainforest
  background(#20542E);
  fill(#79BF3D);
  // draw the disc
  tilt();
  
}

void tilt() {
  // translate from origin to center
  translate(position, position, position);
  
  // x is front to back
  rotateX(radians(roll + 90));
  // y is left to right
  rotateY(radians(pitch));
  
  // set the disc to fill color
  fill(#79BF3D);
  // draw the disk
  ellipse(0, 0, width/4, width/4);
  // set the text fill color
  fill(#20542E);
  // draw some text so you can tell front from back
  text(pitch + "," + roll, -40, 10, 1);
}

void serialEvent(Serial myPort) {
  // read the serial buffer
  String myString = myPort.readStringUntil('\n');
  
  // if you got any bytes other than the linefeed
  if (myString != null) {
    myString = trim(myString);
    // split the string at the commas
    String items[] = split(myString, ',');
    if (items.length > 1) {
      pitch = float(items[0]);
      roll = float(items[1]);    
    }
  }
}










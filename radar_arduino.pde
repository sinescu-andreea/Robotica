import processing.serial.*; // importare librarie pentru serial communication
import java.awt.event.KeyEvent; // importare librarie pentru citire de date din Serial Port
import java.io.IOException;
Serial myPort; // definire Obiect Serial
// definire variable
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont orcFont;
void setup() {
 size (1920, 1080);
 smooth();
 myPort = new Serial(this,"COM4", 9600); // incepere serial communication
 myPort.bufferUntil('.'); // citire date din Serial Port pana la caracterul '.'. Deci a citit: unghiul,distanta.
 orcFont = loadFont("OCRAExtended-30.vlw");
}
void draw() {  
  fill(98,245,31);
  textFont(orcFont);
  // simularea blurului miscarii si decolorarea lenta a liniei in miscare
  noStroke();
  fill(0,4); 
  rect(0, 0, width, 1010); 
  fill(98,245,31); // culoarea verde
  // chemarea functiilor pentru desenarea radarului
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}
void serialEvent (Serial myPort) { // citirea datelor din Serial Port
  // citim datele Serial Port pana la caracterul '.' si le punem in variabila de tip String "data".
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  index1 = data.indexOf(","); // gasirea caracterului ',' si punerea lui in variabila "index1"
  angle= data.substring(0, index1); // citirea datelor din pozitia "0" pana la pozitia index1 
  distance= data.substring(index1+1, data.length()); // citirea datelor de la pozitia "index1" pana la sfarsit
  // convertire string in int
  iAngle = int(angle);
  iDistance = int(distance);
}
void drawRadar() {
  pushMatrix();
  translate(960,1000); // mutarea coordonatelor de start la o noua locatie
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  // draws the arc lines
  arc(0,0,1800,1800,PI,TWO_PI);
  arc(0,0,1400,1400,PI,TWO_PI);
  arc(0,0,1000,1000,PI,TWO_PI);
  arc(0,0,600,600,PI,TWO_PI);
  // draws the angle lines
  line(-960,0,960,0);
  line(0,0,-960*cos(radians(30)),-960*sin(radians(30)));
  line(0,0,-960*cos(radians(60)),-960*sin(radians(60)));
  line(0,0,-960*cos(radians(90)),-960*sin(radians(90)));
  line(0,0,-960*cos(radians(120)),-960*sin(radians(120)));
  line(0,0,-960*cos(radians(150)),-960*sin(radians(150)));
  line(-960*cos(radians(30)),0,960,0);
  popMatrix();
}
void drawObject() {
  pushMatrix();
  translate(960,1000); // mutarea coordonatelor de start la o noua locatie
  strokeWeight(9);
  stroke(255,10,10); // culoarea rosie
  pixsDistance = iDistance*22.5; // transformare distanta din cm in px
  // limitare la 40 de cm
  if(iDistance<40)
  {
    // deseneaza obiectele in functie de unghi si distanta
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),950*cos(radians(iAngle)),-950*sin(radians(iAngle)));
  }
  popMatrix();
}
void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(960,1000); // mutarea coordonatelor de start la o noua locatie
  line(0,0,950*cos(radians(iAngle)),-950*sin(radians(iAngle))); // deseneaza linia in functie de unghi
  popMatrix();
}
void drawText() { // deseneaza textele pe ecran
  pushMatrix();
  if(iDistance>40) {
  noObject = "Out of Range";
  }
  else {
  noObject = "In Range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, 1010, width, 1080);
  fill(98,245,31);
  textSize(25);
  text("10cm",1180,990);
  text("20cm",1380,990);
  text("30cm",1580,990);
  text("40cm",1780,990);
  textSize(40);
  text("Object: " + noObject, 240, 1050);
  text("Angle: " + iAngle +" °", 1050, 1050);
  text("Distance: ", 1380, 1050);
  if(iDistance<40) {
  text("        " + iDistance +" cm", 1400, 1050);
  }
  textSize(25);
  fill(98,245,60);
  translate(961+960*cos(radians(30)),982-960*sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  translate(954+960*cos(radians(60)),984-960*sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  translate(945+960*cos(radians(90)),990-960*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  translate(935+960*cos(radians(120)),1003-960*sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  translate(940+960*cos(radians(150)),1018-960*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
}
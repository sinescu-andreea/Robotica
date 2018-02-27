// Includes the Servo library
#include <Servo.h>. 
// Definirea Trig-ului si echo-ului pentru senzorul ultrasonic
const int trigPin = 10;
const int echoPin = 11;
// Variabile pentru durata si distanta
long duration;
int distance;
Servo myServo; // Crearea unui obiect de tip servo pentru controlarea motorului servo

void setup() {
  pinMode(trigPin, OUTPUT); // Setare trigPin ca Output
  pinMode(echoPin, INPUT); // Setare echoPin ca Input
  Serial.begin(9600);
  myServo.attach(12); // Definirea pinului la care este cuplat motorul
}

void loop() {
  // rotirea servo motorului de la 15 la 165 de grade
  for(int i=15;i<=165;i++){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();// se masoara pt fiecare grad distanta
  Serial.print(i); // se transmite gradul curent Serial Port-ului
  Serial.print(","); // se delimiteza de distanta cu o virgula
  Serial.print(distance); // se transmite distanta curenta Serial Port-ului
  Serial.print("."); // se delimiteaza secventa cu un punct
  }
  // se repeta liniile anterioare pentru gradele de la 165 la 15
  for(int i=165;i>15;i--){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
  }
}
// Functia care calculeaza distanta data de senzorul ultrasonic
int calculateDistance(){ 
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  // Setam trigPin la statut HIGH pentru 10 microseconde
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); // citim echoPin, returnează timpul de deplasare a undelor sonore în microsecunde
  distance= duration*0.034/2;
  return distance;
}

#define NUMBERREADINGS 15 // pentru a mari smoothing-ul
int senseLimit = 10; // pentru a scadea sensitivitatea (pana la 1023 max)
int aerialPin = 5; // pin analog 5 pentru antena
int value = 0; // valoare data de antena

int led1 = 8;   //
int led2 = 7;   //
int led3 = 6;   // ledurile legate in serie
int led4 = 5;   //
int led5 = 4;   //
int led6 = 3;   //
int led7 = 2;   //
int buzzer = 9;
 
// variabile pentru smoothing:
int readings[NUMBERREADINGS];  // citirile din input-ul analog
int index = 0;                 // index-ul citirii curente
int total = 0;                 // totalul citirii
int average = 0;               // media finala a citirii buzzer-ului


void setup() {
  pinMode(led1, OUTPUT);  
  pinMode(led2, OUTPUT); 
  pinMode(led3, OUTPUT); 
  pinMode(led4, OUTPUT); 
  pinMode(led5, OUTPUT); 
  pinMode(led6, OUTPUT); 
  pinMode(led7, OUTPUT); 
  pinMode(buzzer, OUTPUT);
  Serial.begin(9600);  
  for (int i = 0; i < NUMBERREADINGS; i++)
        readings[i] = 0;      //initializam cu 0 fiecare citire
}

void loop() {

  value = analogRead(aerialPin);  // citire a buzzer-ului
  value = constrain(value, 1, senseLimit);  // transformarea oricarei citiri mai mari decat senseLimit in valoarea senseLimit
  value = map(value, 1, senseLimit, 1, 7);  // remaparea valorii restrictionate in intervalul 1-7

  total -= readings[index]; // scaderea ultimei citiri
  readings[index] = value; // citirea de la senzor
  total += readings[index]; // adaugarea citirii la total
  index = (index + 1); // cresterea index-ului

  if (index >= NUMBERREADINGS)  // daca e sfarsitul vectorului atunci
      index = 0;    // pornim cu index-ul de la inceput

  average = total / NUMBERREADINGS; // calcularea mediei
  noTone(buzzer);
  Serial.println(average);
  if (average > 0){ 
    digitalWrite(led1, HIGH);
    tone(buzzer, 2000);
  }
  else{                      
    digitalWrite(led1, LOW);    
  }

  if (average > 1){
    digitalWrite(led2, HIGH);
    tone(buzzer, 2500);
  }
  else{
    digitalWrite(led2, LOW);
  }

  if (average > 2){
    digitalWrite(led3, HIGH);
    tone(buzzer, 3000);
  }
  else{
    digitalWrite(led3, LOW);
  }


  if (average > 3){
    digitalWrite(led4, HIGH);
    tone(buzzer, 3500);
  }
  else{
    digitalWrite(led4, LOW);
  }

  if (average > 4){
    digitalWrite(led5, HIGH);
    tone(buzzer, 4000);
  }
  else{
    digitalWrite(led5, LOW);
  }

  if (average > 5){
    digitalWrite(led6, HIGH);
    tone(buzzer, 4500);
  }
  else{
    digitalWrite(led6, LOW);
  }

  if (average > 6){
    digitalWrite(led7, HIGH);
    tone(buzzer, 5000);
  }
  else{
    digitalWrite(led7, LOW);
  }
}

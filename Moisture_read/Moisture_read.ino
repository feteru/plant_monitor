const int numReadings = 25;
int moist1_readings[numReadings];
int moist2_readings[numReadings];
int readIndex = 0;
int total1 = 0;
int total2 = 0;
int average1 = 0;
int average2 = 0;

int moist_val[2];
int temp_val[2];

void setup() {
  Serial.begin(9600);
  int moistPins[] = {A0, A1};
  int tempPins[] = {A1, A2};
  int outPins[] = {7,8};
  for(int i = 0; i<2; i++) {
    pinMode(tempPins[i], INPUT);
    pinMode(moistPins[i], INPUT);
    pinMode(outPins[i], OUTPUT);
  }
  for(int thisReading = 0; thisReading <numReadings; thisReading++){
    moist1_readings[thisReading] = 0;
    moist2_readings[thisReading] = 0;
  }
}



void loop() {
  
  digitalWrite(7,HIGH);   //write supply voltage high for moisture sensors 
  digitalWrite(8, HIGH); 
  moist_val[0] = analogRead(A0);  //read value from moisture sensors.
  moist_val[1] = analogRead(A1);  //and write it to the moist#_reading array
  digitalWrite(7,LOW);  //write vcc low for the moisture sensors to avoid corrosion.
  digitalWrite(8,LOW);  
  
  total1 -= moist1_readings[readIndex]; //total - the last read value. .
  total2 -= moist2_readings[readIndex]; //total for second sensor
  

  moist1_readings[readIndex] = moist_val[0];    //I might be able to just use moist_val to assign directly
  moist2_readings[readIndex] = moist_val[1];
  
  
    
  total1 = total1 + moist1_readings[readIndex]; 
  total2 = total2 + moist2_readings[readIndex];

//  Serial.print(total1);
//  Serial.print(" ");
//  Serial.println(total2);

  readIndex = readIndex + 1;

  average1 = total1 / numReadings;
  average2 = total2 / numReadings;
  
  if(readIndex >= numReadings){
    readIndex = 0;
  }
  
  temp_val[0] = analogRead(A2);
  temp_val[1] = analogRead(A3);
  
  Serial.print(average1);
  Serial.print(", ");
  Serial.print(average2);
  Serial.print(", ");
  Serial.print(temp_val[0]);
  Serial.print(", ");
  Serial.println(temp_val[1]);

  delay(50);  

}

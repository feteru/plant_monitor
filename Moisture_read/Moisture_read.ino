void setup() {
  Serial.begin(9600);
  int moistPins[] = {A0, A1};
  int outPins[] = {7,8};
  for(int i = 0; i<2; i++) {
    pinMode(moistPins[i], INPUT);
    pinMode(outPins[i], OUTPUT);
  }
}

int moist_val[2];

void loop() {
  digitalWrite(7,HIGH);
  digitalWrite(8, HIGH);
  moist_val[0] = analogRead(A0);
  moist_val[1] = analogRead(A1);
  Serial.print(moist_val[0]);
  Serial.print(", ");
  Serial.println(moist_val[1]);
  digitalWrite(7,LOW);
  digitalWrite(8,LOW);
  delay(500);  

}

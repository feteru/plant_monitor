
void setup() {
  Serial.begin(9600); //begin serial feed
  int moistPin = A0;
  int moistPower = 2;
  int mosit_val;
  pinMode(moistPin, INPUT);
  pinMode(moistPower, OUTPUT);

}

void loop() {
  digitalWrite(moistPower, HIGH);
  moist_val = analogRead(moistPin);
  delayMicroseconds(200);
  digitalWrite(moistPower, LOW):



  Serial.println(moistPower);

}


int moistPin = A0;
int moistPower = 2;
int moistValue;

void setup() {
  Serial.begin(9600); //begin serial feed

  pinMode(moistPin, INPUT);
  pinMode(moistPower, OUTPUT);

}

void loop() {
  digitalWrite(moistPower, HIGH);
  moistValue = analogRead(moistPin);
  delayMicroseconds(200);
  digitalWrite(moistPower, LOW);
  Serial.println(moistValue);
  delay(5);

}

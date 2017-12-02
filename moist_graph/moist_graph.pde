import processing.serial.*;
import processing.io.*;  //for control of GPIO

Serial Port1;
PrintWriter output;

void setup(){
  size(1024,512);
  //fullScreen();
  printArray(Serial.list());
  Port1 = new Serial(this, Serial.list()[0],9600);
  Port1.clear();
  
  GPIO.pinMode(6, GPIO.OUTPUT);
  
  fill(255,0,0);
  //noStroke();
  background(255);
  textSize(15);
  

}

int t=0;
int [] oldpoint = new int[4];  //create array to hold old y values of moisture & temp
int [] newpoint = new int[4]; //array to hold new value
float temperature;

void draw(){
  if(Port1.available() > 0){
    String inString = Port1.readStringUntil('\n');
    if(inString!= null){
      if (t>= width){
        background(255);
        t = 0;
      } else {
        inString = trim(inString);
        String[] ser_val = splitTokens(inString, ", ");  //extract the moisture values     
        if(ser_val.length ==4){
          //println(ser_val[0] + " " + ser_val[1]+ " " + ser_val[2]+ " " + ser_val[3]);
          // int moist1 = int(moist_val[0]);
          int moist1 = int(height - (float)int(ser_val[0])*((float)height/1024));  //convert first moisture value
          int moist2 = int(height - (float)int(ser_val[1])*((float)height/1024)); 
          int temp1 = int(height - (float)int(ser_val[2])*((float)height/1024));  //convert temp value for display
          int temp2 = int(height - (float)int(ser_val[3])*((float)height/1024));
          newpoint[0] = moist1;  //set the new points of the line
          newpoint[1] = moist2;
          newpoint[2] = temp1;
          newpoint[3] = temp2;
          fill(255);
          noStroke();
          rect(0,0,120,50);  //create white rectangle to get rid of the previous text on screen
          fill(255,0,0);
          stroke(120);
          moist1 = int(ser_val[0])*100 / 886;  //moisture scaling for %
          moist2 = int(ser_val[1])*100 / 886;
          if(moist1 < 75){  //moisture threshold
            textSize(30);
            text("MOISTURE 1 LOW",2,20,45);
            textSize(15);
            
            GPIO.digitalWrite(6,GPIO.HIGH);  //open valve
            delay(150);
            GPIO.digitalWrite(6,GPIO.LOW);  //close it again
            
            
          }
          else if(moist2 < 65){
            textSize(30);
            text("MOISTURE 2 LOW",2,200,45);
            textSize(15);
            
            GPIO.digitalWrite(6,GPIO.HIGH);
            delay(150);
            GPIO.digitalWrite(6,GPIO.LOW);
            
          }
          else{
            fill(255);
            noStroke();
            rect(0,0,500,70);  //writes over the "Moisture Low" warning
            fill(255,0,0);
          }
          
          text("Moisture 1: " + moist1  + "%",19,40);  //display Moisture sensor output
          text("Moisture 2: " + moist2 + "%",19,55);
          temperature  = (((float)((int(ser_val[2]) + int(ser_val[3])) /2)/1024.000) * 500.000);  //average the two temperature sensors and scale them
          text("Air temperature:  " + temperature + " degrees",150,40);
          
          int []colors = {255, 0,0,255,0,0};  //colors array that allows me to use a for loop to create the four different lines
          for( int i = 0; i <4; i++){
            stroke(colors[i], colors[i+1], colors[i+2]);
            line(t-2,  oldpoint[i], t, newpoint[i]);
          
          }
          //println(t + ", " + moist1 + ", " + moist2 + ", " + temp1 + ", " + temp2);   
          t += 2;
          oldpoint = newpoint;
        }
      }
    }  
  }    
}  



void keyPressed(){
  exit();
}
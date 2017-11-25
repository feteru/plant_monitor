import processing.serial.*;

Serial Port1;
PrintWriter output;

function setup(){
  createCanvas(1024,512);
  printArray(Serial.list());
  Port1 = new Serial(this, Serial.list()[3],9600);
  Port1.clear();
  fill(255,0,0);
  //noStroke();
  background(255);
}

var t=0;
var [] oldpoint = new Array[4];  //create array to hold old y values of moisture & temp
var [] newpoint = new Array[4]; //array to hold new values

function draw(){
  if(Port1.available() > 0){
    String inString = Port1.readStringUntil('\n');
    if(inString!= null){
      if (t>= 1024){
        background(255);
        t = 0;
      } else {
        inString = trim(inString);
        String[] ser_val = splitTokens(inString, ", ");  //extract the moisture values     
        if(ser_val.length ==4){
          println(ser_val[0] + " " + ser_val[1]+ " " + ser_val[2]+ " " + ser_val[3]);
          // int moist1 = int(moist_val[0]);
          var moist1 = int(height - (float)int(ser_val[0])*((float)height/1024));//int(height - (float)int(moist_val[0])*((float)height/1024));
          var moist2 = int(height - (float)int(ser_val[1])*((float)height/1024)); //int(height - (float)int(moist_val[1])*((float)height/1024));
          var temp1 = int(height - (float)int(ser_val[2])*((float)height/1024));
          var temp2 = int(height - (float)int(ser_val[3])*((float)height/1024));
          newpoint[0] = moist1;
          newpoint[1] = moist2;
          newpoint[2] = temp1;
          newpoint[3] = temp2;
          
          //fill(0,0,255);
          //ellipse(t,moist1,3,3);
          var []colors = {255, 0,0,255,0,0};
          for( var i = 0; i <4; i++){
            stroke(colors[i], colors[i+1], colors[i+2]);
            line(t-2,  oldpoint[i], t, newpoint[i]);
          
          }
          //println(inString);
          println(t + ", " + moist1 + ", " + moist2 + ", " + temp1 + ", " + temp2);   
          t += 2;
          oldpoint = newpoint;
        }
      }
    }  
  }    
}  



function keyPressed(){
  exit();
}
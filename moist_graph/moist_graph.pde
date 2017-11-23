import processing.serial.*;

Serial Port1;
PrintWriter output;

void setup(){
  size(1024,512);
  printArray(Serial.list());
  Port1 = new Serial(this, Serial.list()[3],9600);
  Port1.clear();
  fill(255,0,0);
  noStroke();
  background(150);
}

int t=0;

void draw(){
  if(Port1.available() > 0){
    String inString = Port1.readStringUntil('\n');
    if(inString!= null){
      if (t>= 1024){
        background(150);
        t = 0;
      } else {
        inString = trim(inString);
        String[] moist_val = splitTokens(inString, ", ");  //extract the moisture values     
        if(moist_val.length ==2){
          println(moist_val[0] + " " + moist_val[1]);
          // int moist1 = int(moist_val[0]);
          int moist1 = int(int(moist_val[0]) - 512);//int(height - (float)int(moist_val[0])*((float)height/1024));
          int moist2 = int(moist_val[1]) - 512;//int(height - (float)int(moist_val[1])*((float)height/1024));
          fill(0,0,255);
          ellipse(t,moist1,3,3);
        
          fill(0,255,0);
          ellipse(t,moist2,3,3);
          
          
          println(inString);
          println(t + ", " + moist1 + ", " + moist2);   
          t += 2;
        }
      }
    }  
  }    
}  



void keyPressed(){
  exit();
}
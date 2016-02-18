
color[] c = {#3EC1D3, #F6F7D7, #FF9A00, #FF165D };

float centerX = 256;
float centerY = 256;
Screenshaker screenshake; 

void setup() {
  size(512,512);
  screenshake = new Screenshaker();
  smooth();
  noStroke();
}

void draw() {
  background(255); 
  screenshake.update();

  pushMatrix();
  PVector screenshakeOffset = screenshake.getOffset(); 
  translate(centerX + screenshakeOffset.x, centerY + screenshakeOffset.y); 
  rotate( screenshake.getRotation() );
  
  fill(c[0]);
  rect(-50,-50, 100, 100);


  
  popMatrix();
}

void mouseReleased() {
   screenshake.set( 1, 1 ); 
}



class Screenshaker {
  private PVector offset = new PVector(0, 0); 
  private float rotation = 0; 
  private float decayPerSecond = 1; 
  private float duration = 1; 
  private float intensity = 0; 
  private float timeStamp = 0; 

  Screenshaker() {
  }

  void update() {
    if ( intensity > 0) {
      float currentTime = millis();
      float timeDiff = currentTime - timeStamp; 
      offset.set( random(-intensity, intensity), random(-intensity, intensity) ); 
      rotation = random(-intensity, intensity) * 0.1;       //attenuation on rotation to achieve
                                                            //intensity similar to offset
      intensity -= decayPerSecond * timeDiff * 0.001; 
      timeStamp = currentTime;
    } else {
      println("stop", timeStamp);
      offset.set( 0, 0 ); 
      rotation = 0;
    }
  }

  void set(float _intensity) {
    set(_intensity, duration);
  }

  void set(float _intensity, float _duration) {
    intensity = _intensity; 
    duration = _duration; 
    decayPerSecond = intensity / duration; 
    timeStamp = millis();
    println("start", timeStamp);
  }

  PVector getOffset() {
    return offset;
  }

  float getRotation() {
    return rotation;
  }
}
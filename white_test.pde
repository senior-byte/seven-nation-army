// Exercise 16-6: Instead of replacing the background with green pixels, replace it with another 
// image. What values work well for threshold and what values do not work at all? Try 
// controlling the threshold variable with the mouse.   


// Click the mouse to memorize a current background image
import processing.video.*;

// Variable for capture device
Capture video;
Capture video2;

// Saved background
PImage backgroundImage;
PImage backgroundImage2;
PImage backgroundReplace;

float threshold = 250;
float x = 0;
float y = 0;

void setup() {
  size (640, 440);
  String[] cams = Capture.list();
  println(cams[0]);
  
  video = new Capture(this, width, height, cams[1]); 
  video.start();
  // Create an empty image the same size as the video
  backgroundImage = createImage(video.width, video.height, RGB);
  
  backgroundReplace = loadImage("white.png");  
  
  
}

// New frame available from camera
void captureEvent(Capture video) {
  video.read();
}

void draw() {
  loadPixels();
  video.loadPixels(); 
  backgroundImage.loadPixels();

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width; // Step 1, what is the 1D pixel location
      color fgColor = video.pixels[loc]; // Step 2, what is the foreground color

      // Step 3, what is the background color
      color bgColor = backgroundImage.pixels[loc];

      // Step 4, compare the foreground and background color
      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // Step 5, Is the foreground color different from the background color
      if (diff < threshold) {
        // If so, display the foreground color
        pixels[loc] = fgColor;
      } else {
        // If not, display the beach scene
        pixels[loc] = backgroundReplace.pixels[loc];
      }
    }
  }
  
  //replaces white pixels
  updatePixels();
  
  
  
  x = x +4;  
  y = y+2.9;
  if (x> width) {
    x = 160;
    y = 110;
  }
  
  
  
  pushMatrix();
  scale(-1,1);
  imageMode(CENTER);
  image(video,-320,220, x, y);
  popMatrix();
  
  
}

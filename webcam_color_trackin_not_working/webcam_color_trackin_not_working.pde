// Step 1. Import the video library.
import processing.video.*;

//Step 2. Declare a capture object.
Capture video;
PImage image1,image2,image3,image4,image5;
float threshold = 100f;
float threshold1 = 255f;
int videoHeight = 480;
int videoWidth = 640;

int[] area, xc, yc, averagex, averagey;
int labelCounter = 150;

// Step 5. Read from the camera when a new image is available!
void captureEvent(Capture video) {
  video.read();
}

void setup() {  
  size(1920, 960);//640x480 default

  // Step 3. Initialize Capture object.
  video = new Capture(this, videoWidth, videoHeight);

  // Step 4. Start the capturing process.
  video.start();


  image1 = createImage(video.width, video.height, RGB);
  image2 = createImage(video.width, video.height, RGB);
  image3 = createImage(video.width, video.height, RGB);
  image4 = createImage(video.width, video.height, RGB);
  image5 = createImage(video.width, video.height, RGB);

  area = new int[width*height];
  xc = new int[area.length];
  yc = new int[area.length];
  averagex = new int[area.length];
  averagey = new int[area.length];
}

// Step 6. Display the image.
void draw() { 
  if (video.available() == true) {
    video.read();
  }
  image(video, 0, 0);
  image(image1, videoWidth, 0);
  image(image2, videoWidth*2, 0);
  image(image3, 0, videoHeight);
  image(image4, videoWidth, videoHeight);
  image(image5, videoWidth*2, videoHeight);
  video.loadPixels();
  
  blur(video,image1,27);
  greyScale(image1,image2);
  
  
  image1.updatePixels();
  image2.updatePixels();
  image3.updatePixels();
  image4.updatePixels();
  image5.updatePixels();
}

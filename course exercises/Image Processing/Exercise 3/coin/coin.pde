PImage source, thresholded, dilated, blobDetection;
float colorThresh = 180f;
int labelCounter =50;
int[] area, xc, yc, averagex, averagey;
void setup()
{
  size(1024, 256);// 256*number of images x 256

  source = loadImage("coin.png");
  area = new int[source.width*source.height];
  xc = new int[area.length];
  yc = new int[area.length];
  averagex = new int[area.length];
  averagey = new int[area.length];

  thresholded = createImage(source.width, source.height, RGB);
  dilated = createImage(source.width, source.height, RGB);
  blobDetection = createImage(source.width, source.height, RGB);
  loadImages();
}

//averageX= area / xc;


void draw()
{

  image(source, 0, 0);
  image(thresholded, 256, 0);
  image(dilated, 512, 0);
  image(blobDetection, 768, 0);
  for (int i = 0; i <area.length; i++)
  {
    if (i == 100||i == 150 ||i == 200 ||i == 250)
    {
      ellipseMode(RADIUS);  // Set ellipseMode to CENTER
      fill(#FF03D1);
      noStroke();
      ellipse(averagex[i], averagey[i], 5, 5);  // on source image
       ellipse(averagex[i]+source.width*3, averagey[i], 5, 5);  // on blob image
    }
  }
}

public void loadImages()
{
  thresholded.loadPixels();
  source.loadPixels();
  dilated.loadPixels();
  blobDetection.loadPixels();



  for (int x = 0; x < source.width; x++ ) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) > colorThresh) {
        thresholded.pixels[loc] = color(0); // White
      } else {
        thresholded.pixels[loc] = color(255);   // Black
      }
    }
  }

  //--------------------------DILATION 3x3
  for (int y = 1; y < source.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < source.width-1; x++) { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*source.width + (x + kx);
          // Multiply adjacent pixels based on the kernel values
          sum += brightness(thresholded.pixels[pos])/255;
        }
      }
      if (sum >= 1)
      {
        dilated.pixels[y*source.width + x] = color(255);
        blobDetection.pixels[y*source.width + x] = color(255);
      } else
      {
        dilated.pixels[y*source.width + x] = color(0, 0, 0);
        blobDetection.pixels[y*source.width + x] = color(0, 0, 0);
      }
    }
  }
  //--------------------------grassfire
  for (int x = 1; x< source.width-1; x++)
  {
    for (int y = 1; y< source.height-1; y++)
    {
      if (blobDetection.pixels[y*source.width+x] == color(255))
      {

        labelCounter+=50;
        grassfire(x, y);
        println("blob "+labelCounter+ " has been made!");
        println("blob "+labelCounter+ " number of pixels is : " + area[labelCounter]);
        println("blob "+labelCounter+ " x value is : " + xc[labelCounter]);
        println("blob "+labelCounter+ " y value is : " + yc[labelCounter]);
        averagex[labelCounter] =  xc[labelCounter]/area[labelCounter];
        averagey[labelCounter] =  yc[labelCounter]/area[labelCounter];
        println("blob "+labelCounter+ " 's average of x is :"+ averagex[labelCounter]);
        println("blob "+labelCounter+ " 's average of y is :"+ averagey[labelCounter]);
      }
    }
  }
  thresholded.updatePixels();
  dilated.updatePixels();
  blobDetection.updatePixels();
}




void grassfire(int x, int y)
{
  blobDetection.pixels[y*source.width+x] = labelCounter;
  area[labelCounter]++;
  xc[labelCounter]+=x;
  yc[labelCounter]+=y;
  int negativY = y-1;
  int positivY = y+1;

  if (x+1< blobDetection.width &&  blobDetection.pixels[y*source.width+x+1] == color(255))
  {
    grassfire(x+1, y);
  }
  if (y+1< blobDetection.height &&  blobDetection.pixels[positivY*source.width+x] == color(255))
  {
    grassfire(x, y+1);
  }
  if (x-1>=0 &&  blobDetection.pixels[y*source.width+x-1] == color(255))
  {
    grassfire(x-1, y);
  }
  if (y-1>=0 &&  blobDetection.pixels[negativY*source.width+x] == color(255))
  {
    grassfire(x, y-1);
  }
}

 PImage source, thresholded,dilated,blobDetection;
float colorThresh = 180f;
int labelCounter =0;

void setup()
{
  size(1024,256);// 256*number of images x 256
  
source = loadImage("coin.png");

thresholded = createImage(source.width,source.height,RGB);
dilated = createImage(source.width,source.height,RGB);
blobDetection = createImage(source.width,source.height,RGB);
loadImages(); 
}

void draw()
{
  
  image(source,0,0);
  image(thresholded,256,0);
  image(dilated,512,0);
  image(blobDetection,768,0);
}

public void loadImages()
{
    loadPixels();
  thresholded.loadPixels();
  source.loadPixels();
  dilated.loadPixels();
  blobDetection.loadPixels();


  
  for (int x = 0; x < source.width; x++ ) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) > colorThresh){
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
   if(sum >= 1)
   {
       dilated.pixels[y*source.width + x] = color(255);
       blobDetection.pixels[y*source.width + x] = color(255);
   }
   else
   {
       dilated.pixels[y*source.width + x] = color(0,0,0);
       blobDetection.pixels[y*source.width + x] = color(0,0,0);
   }
  
    }
   }
 //--------------------------grassfire
 for(int x = 1; x< source.width-1;x++)
    {
     for(int y = 1; y< source.height-1;y++)
     {
       if(blobDetection.pixels[y*source.width+x] == color(255))
       {

         labelCounter++;
         grassfire(x,y);
         colorSelector(labelCounter);
        
       }
     }
  }
  
  thresholded.updatePixels();
  dilated.updatePixels();
  blobDetection.updatePixels();
}




 void grassfire(int x,int y)
{
 dilated.pixels[y*source.width+x] = labelCounter;
 int newY = y-1;
 
 if(x+1< dilated.width &&  dilated.pixels[y*source.width+x+1] == color(255))
 {
   grassfire(x+1,y);
 }
  if(y+1< dilated.height &&  dilated.pixels[(1+y)*source.width+x] == color(255))
 {
   grassfire(x,y+1);
 }
  if(x-1>=0 &&  dilated.pixels[y*source.width+x-1] == color(255))
 {
   grassfire(x-1,y);
 }
  if(y-1>=0 &&  dilated.pixels[newY*source.width+x] == color(255))
 {
   grassfire(x,y-1);
 }
 println(labelCounter);
}

void colorSelector(int label)
{
  for(int x = 1; x< source.width-1;x++)
    {
     for(int y = 1; y< source.height-1;y++)
     {
  if(label == 0)
  {
    dilated.pixels[y*source.width+x] = color(0,102,204);
  }
  if(label == 2)
  {
    dilated.pixels[y*source.width+x] = color(0,0,255);
  }
  if(label == 1)
  {
    dilated.pixels[y*source.width+x] = color(0,255,0);
  }
  if(label == 3)
  {
    dilated.pixels[y*source.width+x] = color(255,0,0);
  }
     }
    }
}

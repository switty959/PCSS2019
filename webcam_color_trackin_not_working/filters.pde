void skinDetection(PImage selectedImage,PImage changedImage )
{
  for (int y = 0; y < videoHeight; y++) 
  {
    for (int x = 0; x < videoWidth; x++) 
    {
      int loc = x+y*videoWidth;

      float R = red(selectedImage.pixels[loc]);
      float G = green(selectedImage.pixels[loc]);
      float B = blue(selectedImage.pixels[loc]);
      
        if (R > 95 & G >40  & B > 20  & R > B & ( R -G ) > 15)
        {
          changedImage.pixels[loc] = color(255);
        } else
        {
          changedImage.pixels[loc] = color(0);
        }
    }
  }
}

//Median
void median (PImage selectedImage,PImage changedImage )
{         
  for (int y = 1; y < videoHeight -1; y++) {
    for (int x = 1; x < videoWidth -1; x++) {
      float[] list = new float[9];
      int kernelCounter = 0;


      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (y + ky)*videoWidth + (x + kx);
          list[kernelCounter] = brightness(selectedImage.pixels[pos]);
          kernelCounter++;
        }
      }
      // printArray(list);
      list = sort(list);
      changedImage.pixels[y*videoWidth + x] = color(list[5]); // take median value as value
    }
  }
}

//dilation
void dilation(PImage selectedImage,PImage changedImage,int kernels)
{
  for (int y = kernels; y < videoHeight-kernels; y++) 
  { // Skip top and bottom edges
    for (int x = kernels; x < videoWidth-kernels; x++)
    { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = kernels*-1; ky <= kernels; ky++) 
      {
        for (int kx = kernels*-1; kx <= kernels; kx++) 
        {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*videoWidth + (x + kx);
          // Multiply adjacent pixels based on the kernel values
          sum += brightness(selectedImage.pixels[pos])/255;
        }
      }
      if (sum >= 1)
      {
        changedImage.pixels[y*videoWidth + x] = color(255);
      } else
      {
        changedImage.pixels[y*videoWidth + x] = color(0);
      }
    }
  }
}

//Erosion
void erosion(PImage selectedImage,PImage changedImage,int kernels)
{
  for (int y = kernels; y < videoHeight-kernels; y++) { // Skip top and bottom edges
    for (int x = kernels; x < videoWidth-kernels; x++) { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = kernels*-1; ky <= kernels; ky++) {
        for (int kx = kernels*-1; kx <= kernels; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*videoWidth + (x + kx);
          // Multiply adjacent pixels based on the kernel values
          sum += brightness(selectedImage.pixels[pos])/255;
        }
      }
      if (sum == 25)
      {
        changedImage.pixels[y*videoWidth + x] = color(255, 255, 255);
      } else
      {
        changedImage.pixels[y*videoWidth + x] = color(0, 0, 0);
      }
    }
  }
}

void blur(PImage selectedImage,PImage changedImage,float blurness)
{
  float v = 1.0 / blurness;
  float[][] kernel = {{ v, v, v }, 
    { v, v, v }, 
    { v, v, v }};
  // Loop through every pixel in the image
  for (int y = 1; y < videoHeight-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < videoWidth-1; x++) {  // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*videoWidth + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(selectedImage.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      changedImage.pixels[y*videoWidth + x] = color(sum);
    }
  }
}

//greyscale filter
void greyScale(PImage selectedImage,PImage changedImage)
{
  for (int x =0; x<videoWidth; x++)
  {
    for (int y =0; y<videoHeight; y++)
    {
      int loc = x+y*videoWidth;

      float R = red(selectedImage.pixels[loc]);
      float G = green(selectedImage.pixels[loc]);
      float B = blue(selectedImage.pixels[loc]);
      float average = (R+G+B)/3;
      changedImage.pixels[loc] = color(average);
    }
  }
}

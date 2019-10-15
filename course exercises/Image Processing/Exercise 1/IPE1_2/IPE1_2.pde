PImage source; //source image, image to start off with
PImage fixed; //fixed image



void setup() {
  size(256, 256);
  source = loadImage("lena.jpg"); // Load the original image
  
float v = 1.0 / 9.0;
float[][] kernel = {{ v, v, v }, 
                    { v, v, v }, 
                    { v, v, v }};
                   
  noLoop();
} 

void draw() {
  //image(img, 0, 0); // Displays the image from point (0,0) 
  loadPixels();

  // Create an opaque image of the same size as the original
 // PImage edgeImg = createImage(img.width, img.height, RGB);

        for (int i = 0; i < source.height * source.width; i++) {
                if (random(1) < 0.05) { // add noise
                        if (random(1) <= 0.5) {
                                pixels[i] = color(255);
                        }
                        else {
                                pixels[i] = color(0);
                        }
                }
                else
                {
                  // make grayscale
                        float r = red(source.pixels[i]);
                        float g = green(source.pixels[i]);
                        float b = blue(source.pixels[i]);
                        float grey = (r/3) + (g/3) + (b/3);
                        pixels[i] = color(grey);

                }
        }
          updatePixels();
          
        for (int y = 1; y < source.height -1; y++) {
                for (int x = 1; x < source.width -1; x++) {
                        float[] list = new float[9];
                        int kernelCounter = 0;
                        float val = brightness(pixels[y*width + x]);
                        if (val == 255 || val == 0) { // if salt or pepper
                        
                                for (int ky = -1; ky <= 1; ky++) {
                                        for (int kx = -1; kx <= 1; kx++) {
                                                int pos = (y + ky)*width + (x + kx);
                                                list[kernelCounter] = brightness(pixels[pos]);
                                                kernelCounter++;
                                        }
                                }
                                // printArray(list);
                                list = sort(list);
                                pixels[y*width + x] = color(list[5]); // take median value as value

                        }
                }
        }
        updatePixels();


}

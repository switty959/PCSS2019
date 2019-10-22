void grassfire(int x, int y,PImage blobedImage)
{
  blobedImage.pixels[y*videoWidth+x] = labelCounter;
  area[labelCounter]++;
  xc[labelCounter]+=x;
  yc[labelCounter]+=y;
  int negativY = y-1;
  int positivY = y+1;

  if (x+1< blobedImage.width &&  blobedImage.pixels[y*videoWidth+x+1] == color(255))
  {
    grassfire(x+1, y,blobedImage);
  }
  if (y+1< blobedImage.height &&  blobedImage.pixels[positivY*videoWidth+x] == color(255))
  {
    grassfire(x, y+1,blobedImage);
  }
  if (x-1>=0 && blobedImage.pixels[y*videoWidth+x-1] == color(255))
  {
    grassfire(x-1, y,blobedImage);
  }
  if (y-1>=0 &&  blobedImage.pixels[negativY*videoWidth+x] == color(255))
  {
    grassfire(x, y-1,blobedImage);
  }
}

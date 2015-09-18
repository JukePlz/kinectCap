// Processing 2.2 + SimpleOpenNI
// Kinect for Windows 1.7 SDK

import SimpleOpenNI.*;
import java.io.File;

SimpleOpenNI context;

String operation;

void setup()
{

  size(100, 100);

  frame.dispose();
  frame.setUndecorated(true);

  background(0);

  context = new SimpleOpenNI(this);
  context.enableRGB();

  File screenCap = new File("C:/screenCap.jpg");
  if (screenCap.exists())
  {
    screenCap.delete();
  }

  File screenCapNew = new File("C:/screenCapNew.jpg");
  if (screenCapNew.exists())
  {
    screenCapNew.delete();
  }

  operation = "";

  fill(255, 200, 30);
  textSize(28);
  text("Kin", width/2 - 35, 52);
  text("Cap", width/2 - 20, 77);
}

void draw()
{
  frame.setLocation(displayWidth - width - 30, 0);
  context.update();

  if (frameCount % 5 == 0)
  {
    PImage capturaKinect = context.rgbImage();

    rect(0, 0, width, 15);
    pushStyle();
    fill(0);
    textSize(10);
    text(operation, width - 40, 12);
    popStyle();

    operation = "Waiting";
    File screenCapNew = new File("C:/screenCapNew.jpg");

    if (!screenCapNew.exists())
    {
      operation = "Save";
      capturaKinect.save("C:/screenCapNew.jpg");
    }

    File screenCap = new File("C:/screenCap.jpg");

    if (!screenCap.exists())
    {
      operation = "Rename";
      screenCapNew.renameTo(screenCap);
    }
  }
}

void keyPressed()
{
  if (key==ESC)
  {
    key=0;

    operation = "Exiting";
    rect(0, 0, width, 15);
    pushStyle();
    fill(0);
    textSize(10);
    text(operation, width - 40, 12);
    popStyle();

    File screenCap = new File("C:/screenCap.jpg");
    if (screenCap.exists())
    {
      screenCap.delete();
    }

    File screenCapNew = new File("C:/screenCapNew.jpg");
    if (screenCapNew.exists())
    {
      screenCapNew.delete();
    }

    exit();
  }
}


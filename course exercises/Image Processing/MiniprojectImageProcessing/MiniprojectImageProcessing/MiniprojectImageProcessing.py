import cv2
import numpy as np
#getting native webcam from computer
cam = cv2.VideoCapture(0)

#getting the first frame
_,firstFrame = cam.read()
#conventing to grayscale
firstGray = cv2.cvtColor(firstFrame,cv2.COLOR_BGR2GRAY)
#applying gaussian blur
firstGray = cv2.GaussianBlur(firstGray,(5,5),0)

while True:
    #read output of webcam
    ret,output = cam.read()

    #conventing to grayscale
    greyFrames = cv2.cvtColor(output,cv2.COLOR_BGR2GRAY)
    #applying gaussian blur
    greyFrames = cv2.GaussianBlur(greyFrames,(5,5),0)

    #difference between the first frame and webcam output
    difference = cv2.absdiff(firstGray,greyFrames)
    #making the difference into bit color
    _, difference = cv2.threshold(difference,25,255,cv2.THRESH_BINARY)

    #display windows to show different feed
    cv2.imshow("first frame",firstFrame)
    cv2.imshow("webcam with face detection",output)
    cv2.imshow("difference",difference)
        #wait key for break while loop
    if cv2.waitKey(1) == ord('0'):
        break #stop the loop
cam.release # stop the camera
cv2.destroyAllWindows() # kill display windows


#low/high pass filters
#---------------------------------------------------------------------------------------------
#hkernel = np.array([[-1,-1,-1],
#                   [-1,9,-1],
#                   [-1,-1,-1]])

#image that im using
#img = cv2.imread("images/myHero.jpg",0)

#for resizing the image
#scale_percent = 40 #percent of how much the image should be scaled to
#width = int(img.shape[1] * scale_percent / 100) #calculating the width for resize
#height = int(img.shape[0] * scale_percent / 100)#calculating the height for resize

#resized = cv2.resize(img, (width, height), interpolation = cv2.INTER_AREA) # same image as img but resized

#highPass = cv2.filter2D(resized,-1,hkernel)#applying a high filter to img
#lowPass = cv2.blur(resized,(10,10))#applying a low filter to img

#cv2.imshow("My hero",resized) # default image
#cv2.imshow("Low pass filter",lowPass)# low pass filter image
#cv2.imshow("High pass filter",highPass) # high pass filter image
#cv2.waitKey(0)
#cv2.destroyAllWindows() # kill display windows
#---------------------------------------------------------------------------------------------



#webcam with face detection
#---------------------------------------------------------------------------------------------
#getting the haar cascade for frontal face
#faceDetect = cv2.CascadeClassifier('haarcascade/haarcascade_frontalface_default.xml')

#getting native webcam from computer
#cam = cv2.VideoCapture(0)

#while True:
    #read output of webcam
    #ret,output = cam.read()
    
    #convent webcam output to grayscale
    #grayScale = cv2.cvtColor(output,cv2.COLOR_BGR2GRAY)
    #facedetection through the haar cascasde
    #faces = faceDetect.detectMultiScale(grayScale,1.1,5)
    #for(x,y,w,h) in faces: #for loop that run through faces which is a collection 
                           # of all the faces that were found
        #drawing a square with x and y coordinates and adding the color and stroke
        #cv2.rectangle(output,(x,y),(x+w,y+h),(0,0,255),2)
        #creating a windows that show webcam with rectangle
        #cv2.imshow("webcam with face detection",output)
        #wait key for break while loop
    #if cv2.waitKey(1) == ord('0'):
        #break #stop the loop
#cam.release # stop the camera
#cv2.destroyAllWindows() # kill display windows
#---------------------------------------------------------------------------------------------




#background subtraction
#---------------------------------------------------------------------------------------------
#getting native webcam from computer
#cam = cv2.VideoCapture(0)

#getting the first frame
#_,firstFrame = cam.read()
#conventing to grayscale
#firstGray = cv2.cvtColor(firstFrame,cv2.COLOR_BGR2GRAY)
#applying gaussian blur
#firstGray = cv2.GaussianBlur(firstGray,(5,5),0)

#while True:
    #read output of webcam
    #ret,output = cam.read()

    #conventing to grayscale
    #greyFrames = cv2.cvtColor(output,cv2.COLOR_BGR2GRAY)
    #applying gaussian blur
    #greyFrames = cv2.GaussianBlur(greyFrames,(5,5),0)

    #difference between the first frame and webcam output
    #difference = cv2.absdiff(firstGray,greyFrames)
    #making the difference into bit color
    #_, difference = cv2.threshold(difference,25,255,cv2.THRESH_BINARY)

    #display windows to show different feed
    #cv2.imshow("first frame",firstFrame)
    #cv2.imshow("webcam with face detection",output)
    #cv2.imshow("difference",difference)
        #wait key for break while loop
    #if cv2.waitKey(1) == ord('0'):
        #break #stop the loop
#cam.release # stop the camera
#cv2.destroyAllWindows() # kill display windows
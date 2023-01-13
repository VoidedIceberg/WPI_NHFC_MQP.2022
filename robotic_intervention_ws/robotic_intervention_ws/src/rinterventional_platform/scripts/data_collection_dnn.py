#! /usr/bin/env python3
import cv2

import math
import numpy as np


#READ ME: delete the things in Extracted/Frames and Extracted/Video folder in current route everytime before you run this.
#And make sure you have Extracted/Frames and Extracted/Video folder in current route

class neuroint_data_collection():
    def __init__(self):

        # Opens the camera with correspond camara index (use the next block of code to check) to capture video.
        self.cap_1 = cv2.VideoCapture(0)
        self.cap_2 = cv2.VideoCapture(2)
        #vid_cod = cv2.VideoWriter_fourcc(*'XVID')
        #self.video_output_1 = cv2.VideoWriter('Extracted/Video_1/cam_video_1.mp4', vid_cod, 20.0, (640,480))
        #self.video_output_2 = cv2.VideoWriter('Extracted/Video_2/cam_video_2.mp4', vid_cod, 20.0, (640,480))

        try:
            self.run()
        except ValueError:
            print("Action terminated.")
        finally:
            #close camara
            self.cap_1.release()
            self.cap_2.release()
            #self.video_output_1.release()
            #self.video_output_2.release()
            cv2.destroyAllWindows()
            # save trajectory into csv file
    def run(self):
        i = 0
        while (True):
            ret_1, frame_1 = self.cap_1.read()
            ret_2, frame_2 = self.cap_2.read()
            cv2.imshow("My cam video", frame_2)
            # Save Frame by Frame into disk using imwrite method
            # cv2.imwrite('Extracted/Frames_1/Frame_1_'+str(i)+'.jpg', frame_1)
            # #self.video_output_1.write(frame_1)
            # cv2.imwrite('Extracted/Frames_2/Frame_2_'+str(i)+'.jpg', frame_2)
            #self.video_output_2.write(frame_2)
            i += 1

            if cv2.waitKey(1) & 0xFF == ord('q'):
                break


if __name__ == '__main__':
    whatever = neuroint_data_collection()
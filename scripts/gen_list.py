

import os
from os import listdir, getcwd
from os.path import join
import json

classes = ["hamburger menu", "shopping cart"]

walkPattern = "labels"
    
wd = getcwd()
list_file_train = open('train.txt', 'w')
list_file_test = open('test.txt', 'w')

for root, dirs, files in os.walk(os.path.join(wd, walkPattern)):
    for name in files:
        label_file = os.path.join(root, name)
        image_file = label_file.replace(walkPattern, "images").replace(".txt", ".png").replace(".json", ".png")
        if not os.path.exists(label_file) or not os.path.exists(image_file):
            print ("!!Warning, cannot find file", label_file, image_file)
            continue
        
        list_file = list_file_train if label_file.find('test_') == -1 else list_file_test
        list_file.write('%s\n'%image_file)
 
 list_file_train.close()
 list_file_test.close()


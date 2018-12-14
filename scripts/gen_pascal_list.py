

import os
from os import listdir, getcwd
from os.path import join
import json

from PIL import Image

wd = getcwd()

train_file = 'ImageSets/Main/trainval.txt'
test_file = 'ImageSets/Main/test.txt'

list_file_train = open(train_file, 'w')
list_file_test = open(test_file, 'w')

num_train_images=0
num_test_images=0

walkPattern = "Annotations"

def get_image_path(name, ext = ''):
    return os.path.join(wd, "JPEGImages", name + ext)

def process_one_image(name):
    global num_test_images, num_train_images, walkPattern

    label_file = os.path.join(wd, walkPattern, name + '.xml')

    image_file = get_image_path(name, '.jpg')
    if not os.path.exists(image_file):

        png_file = get_image_path(name, '.png')
        if not os.path.exists(png_file):
            print ("!!Warning, cannot find file %s, and no png." % image_file)
            return

        print("Found png file, convert to JPG and use it: %s" % name)
        im = Image.open(png_file)
        im = im.convert('RGB')
        im.save(image_file)

    is_train_image = name.find('test_') == -1

    if is_train_image:
        num_train_images += 1
    else:
        num_test_images += 1

    pure_name = name
    
    list_file = list_file_train if is_train_image else list_file_test
    list_file.write('%s\n'%pure_name)


for root, dirs, files in os.walk(os.path.join(wd, walkPattern)):
    for name in files:

        pure_name = os.path.splitext(name)[0]

        norm_name = pure_name.replace(' ', '__')
        if norm_name != pure_name:
            label_file = os.path.join(root, name)

            print("File name contains space, rename the label file and image file to %s" % norm_name)
            os.rename(label_file, os.path.join(root, norm_name + '.xml'))

            exts = [".png", ".jpg"]
            for ext in exts:
                img_file = get_image_path(pure_name, ext)
                if os.path.exists(img_file):
                    os.rename(img_file, get_image_path(norm_name, ext))

        process_one_image(norm_name)
 
list_file_train.close()

if num_test_images == 0:
    f = open(train_file, 'r')
    c = f.read()
    list_file_test.write(c)
    f.close()

list_file_test.close()


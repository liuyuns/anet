

import os, sys, getopt, argparse

from os import listdir, getcwd
from os.path import join
import json

work_dir = os.path.join(os.path.dirname(__file__), '..')

name_file = os.path.join(work_dir, 'data/anet.names')
num_of_names = 0
with open(name_file, 'r') as f:
    lines = f.readlines()
    for line in lines:
        if line and len(line) > 0:
            num_of_names += 1

num_of_filters = (num_of_names + 5) * 3

def print_general_info():
    print ('num of names: #%d, filters: #%d = (%d+5)*3' % (num_of_names, num_of_filters, num_of_names))

def update_net_resolution(lines, w, h):
    for i, e in enumerate(lines):
        if e.find('width') == 0:
            lines[i] = "width=%d\n"%w
            print('set width to %d'% w)
        if e.find('height') == 0:
            lines[i] = "height=%d\n"%h
            print('set height to %d'% h)

def update_anchors(lines, anchors):
    count = 0
    for i, e in enumerate(lines):
        if e.find('anchors') == 0:
            lines[i] = "anchors=%s\n"%anchors
            count += 1

    print('updated %d anchors to %s' % (count, anchors))

def update_classes_and_filters(lines):
    """
    update the classes of yolo layer, and filters in the convolutional layer before the yolo layer.
    """

    count_class_change, count_filter_change = (0, 0)

    class_changed = False
    for i, e in reversed(list(enumerate(lines))):
        if e.find('classes=') == 0:
            lines[i] = 'classes=%d\n' % num_of_names
            class_changed = True
            count_class_change += 1

        if class_changed and e.find('filters=') == 0:
            lines[i] = 'filters=%d\n' % num_of_filters
            class_changed = False
            count_filter_change += 1
    
    print ('updated %d classes, %d filters' % (count_class_change, count_filter_change))

def main():
    parser = argparse.ArgumentParser(description='Update classes/filters/anchors for yolo cfg.')
    parser.add_argument('cfg_name')
    parser.add_argument('--update-classes', dest='update_classes', action='store_true',
                        help='update number of classes and filters.')
    parser.add_argument('--update-anchors', dest='update_anchors', action='store_true',
        help='update anchors.')
    parser.add_argument('--anchors-file', dest='anchors_file')
    parser.add_argument('--width', type=int, help='network width')
    parser.add_argument('--height', type=int, help='network width')
    # parser.add_argument('--sum', dest='accumulate', action='store_const',
    #                     const=sum, default=max,
    #                     help='sum the integers (default: find the max)')

    args = parser.parse_args()

    print_general_info()

    cfg_file = os.path.join(work_dir, './cfg/%s.cfg' % args.cfg_name)

    lines = []
    with open(cfg_file, 'r', newline='\n') as cfg_content:
        lines = cfg_content.readlines()
        if args.update_classes:
            update_classes_and_filters(lines)

        
        if args.width and args.height:
            update_net_resolution(lines, args.width, args.height)
        
        if args.update_anchors:
            if args.anchors_file == None:
                print('warning: anchor file is not provided')
            else:
                with open(args.anchors_file, 'r') as f:
                    anchors = f.readline()
                update_anchors(lines, anchors)

    with open(cfg_file, 'w', newline='\n') as cfg_writter:
        cfg_writter.writelines(lines)

if __name__ == '__main__':
    main()


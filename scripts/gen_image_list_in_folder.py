

import os, sys
from os import listdir, getcwd
from os.path import join
import json

def main():
    if len(sys.argv) < 2:
        print('Usage: ', sys.argv[0], '[Folder]')
        return

    folder = os.path.normpath(sys.argv[1])
    out_file = os.path.join(folder, 'test.txt')

    print('folder', folder, 'out file: ', out_file)

    list_file_test = open(out_file, 'wb')
    lines = []
    for file in os.listdir(folder):
        path = os.path.normpath(os.path.join(folder, file))

        if os.path.isfile(path) and (path.endswith('.png') or path.endswith('.jpg')):
            lines.append((path + '\n').encode())
            # list_file_test.write(path.encode())
    

    list_file_test.writelines(lines)
    list_file_test.close()


if __name__ == '__main__':
    main()


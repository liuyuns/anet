
import os, sys, re

from PIL import Image, ImageOps, ImageMath

def main():

    if len(sys.argv) < 4:
       print(f"Usage. {__file__} [image_folder] [width] [height]")
       return


    folder = sys.argv[1]
    width, height = int(sys.argv[2]), int(sys.argv[3])

    print(f"Image folder: {folder}, size: {width} x {height}")

    for file in os.listdir(folder):
        file_path = os.path.join(folder, file)

        if os.path.isdir(file_path) or not (file.endswith('.png') or file.endswith('.jpg')):
            continue

        print('file', file, file_path)

        image = Image.open(file_path)

        image = image.resize((width, height), Image.LANCZOS)

        image.save(file_path)


if __name__ == '__main__':
    main()

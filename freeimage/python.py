# Python script for performance comparison

# Thanks to /u/Veedrac (reddit.com):

from __future__ import division, print_function

import multiprocessing
import time

from PIL import Image

def create_image(filename):
    img = Image.new("RGBA", (640, 480), "black")
    img.putpixel((100, 100), (255, 255, 0, 255))
    img.save(filename)

def average_image(filename):
    img = Image.open(filename)
    img_data = img.load()
    width, height = img.size

    r_sum = g_sum = b_sum = 0
    for yi in range(width):
        for xi in range(height):
            r, g, b, a = img_data[yi, xi]
            r_sum += r
            g_sum += g
            b_sum += b

    num_pixels = width * height
    r_avg = r_sum / num_pixels
    g_avg = g_sum / num_pixels
    b_avg = b_sum / num_pixels

def worker(filename):
    create_image(filename)
    average_image(filename)

def generate_1000(filenames):
    for filename in filenames:
        worker(filename)

def generate_1000_parallel(filenames):
    multiprocessing.Pool(4).map(worker, filenames)

def main():
    def time_func(function, folder):
        start_time = time.time()
        function("{}/python_{}.png".format(folder, i) for i in range(1000))
        return time.time() - start_time

    serial_time = time_func(generate_1000, "img")
    print("1000 images in serial: ", serial_time, " sec")

    parallel_time = time_func(generate_1000_parallel, "img_parallel")
    print("1000 images in parallel: ", parallel_time, " sec")

if __name__ == "__main__":
    main()


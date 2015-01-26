# Python script for performance comparision

from PIL import Image
import time
from joblib import Parallel, delayed

def create_image(folder, i):
    filename = folder + "/python_" + str(i) + ".png"
    img = Image.new("RGBA", (640, 480), "black")
    img.putpixel((100, 100), (255, 255, 0, 255))
    img.save(filename)

def average_image(folder, i):
    filename = folder + "/python_" + str(i) + ".png";
    img = Image.open(filename)
    imgData = img.load()
    imgSize = img.size
    
    r_avg = 0.0
    g_avg = 0.0
    b_avg = 0.0
    count = 0.0
    for yi in range(0, imgSize[0]):
        for xi in range(0, imgSize[1]):
            col = imgData[yi, xi]
            r_avg = (r_avg*count + col[0])/(count + 1)
            g_avg = (g_avg*count + col[1])/(count + 1)
            b_avg = (b_avg*count + col[2])/(count + 1)
            count = count + 1

def generate_1000():
    start_time = time.time()
    for i in range(0, 1000):
        create_image("img", i)
        average_image("img", i)
    elapsed_time = time.time() - start_time
    print "1000 images in serial: ", elapsed_time, " sec"

def worker(i):
    create_image("img_parallel", i)
    average_image("img_parallel", i)

def generate_1000_parallel():
    start_time = time.time()
    Parallel(n_jobs = 4)(delayed(worker)(i) for i in range(0, 1000))
    elapsed_time = time.time() - start_time
    print "1000 images in parallel: ", elapsed_time, " sec"

def main():
    generate_1000()
    generate_1000_parallel()

if __name__ == "__main__":
    main()

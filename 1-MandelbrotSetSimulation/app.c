#include "sim.h"

#include <stdint.h>
#include <math.h>

#define MAX_ITERATIONS 100

static double mandelbrotBuf[SIM_Y_SIZE][SIM_X_SIZE];
static int colorBuf[SIM_Y_SIZE][SIM_X_SIZE];

static double centerX = -0.5;
static double centerY = 0.0;
static double scale = 3.0;

static int calcMandelbrot(int cx, int cy, int scaleShift) {
    int x = 0, y = 0;
    int x2 = 0, y2 = 0;
    int iter = 0;
    
    while (iter < MAX_ITERATIONS) {
        // Проверяем условие |z| < 2
        if (x2 + y2 > (4 << (2 * scaleShift))) {
            break;
        }
            
        // Вычисляем следующую итерацию: z = z² + c
        // Для целых чисел: xNew = x² - y² + cx
        //                  yNew = 2*x*y + cy
        int xNew = ((x2 - y2) >> scaleShift) + cx;
        int yNew = ((2 * ((x * y) >> scaleShift)) >> scaleShift) + cy;
        
        x = xNew;
        y = yNew;
        
        // Вычисляем квадраты для следующей итерации
        x2 = (x * x) >> scaleShift;
        y2 = (y * y) >> scaleShift;
        
        iter++;
    }

    return iter;
}

static int iter2Color(int iter) {
    if (iter == MAX_ITERATIONS)
    { return 0xFF000000; }
    
    int r = (iter * 8) % 256;
    int g = (iter * 5) % 256;
    int b = (iter * 3) % 256;
    
    return 0xFF000000 | (r << 16) | (g << 8) | b;
}

static void calcFrame(void) {
    int scaleShift = 12;
    int centerX = -2000;
    int scale = 4000;
    
    for (int y = 0; y < SIM_Y_SIZE; ++y) {
        for (int x = 0; x < SIM_X_SIZE; ++x) {
            int cx = ((x - SIM_X_SIZE / 2) * scale) / SIM_X_SIZE + centerX;
            int cy = ((y - SIM_Y_SIZE / 2) * scale) / SIM_Y_SIZE;
            
            int iter = calcMandelbrot(cx, cy, scaleShift);
            colorBuf[y][x] = iter2Color(iter);
        }
    }
}

static void drawFrame(void) {
    for (int y = 0; y < SIM_Y_SIZE; ++y) {
        for (int x = 0; x < SIM_X_SIZE; ++x) {
            simPutPixel(x, y, colorBuf[y][x]);
        }
    }
    simFlush();
}

void app(void) {
    // start from
    int startCenterX = -5000;
    int startCenterY = 0;
    int startScale = 10000;
    
    // end on
    int endCenterX = -7500;
    int endCenterY = 1000;
    int endScale = 100;
    
    const int TOTAL_STEPS = 200;
    
    for (int step = 0; step < TOTAL_STEPS; ++step) {
        int currentCenterX = startCenterX + 
            ((endCenterX - startCenterX) * step) / TOTAL_STEPS;
        
        int currentCenterY = startCenterY + 
            ((endCenterY - startCenterY) * step) / TOTAL_STEPS;
        
        int progress = step;
        int currentScale;
        
        if (progress < TOTAL_STEPS / 2) {
            // slow zoom
            currentScale = startScale - 
                ((startScale - startScale / 10) * progress) / (TOTAL_STEPS / 2);
        } else {
            // fast zoom
            int fastProgress = progress - TOTAL_STEPS / 2;
            currentScale = startScale / 10 - 
                ((startScale / 10 - endScale) * fastProgress) / (TOTAL_STEPS / 2);
        }
        
        // calculate frame
        for (int y = 0; y < SIM_Y_SIZE; ++y) {
            for (int x = 0; x < SIM_X_SIZE; ++x) {
                int cx = ((x - SIM_X_SIZE / 2) * currentScale) / SIM_X_SIZE + currentCenterX;
                int cy = ((y - SIM_Y_SIZE / 2) * currentScale) / SIM_Y_SIZE + currentCenterY;
                
                int iter = calcMandelbrot(cx, cy, currentScale / 100 + 1);
                colorBuf[y][x] = iter2Color(iter);
            }
        }
        
        for (int y = 0; y < SIM_Y_SIZE; ++y) {
            for (int x = 0; x < SIM_X_SIZE; ++x) {
                simPutPixel(x, y, colorBuf[y][x]);
            }
        }
        simFlush();
        
        // Простая задержка
        for (volatile int i = 0; i < 50000; ++i) {}
    }
}


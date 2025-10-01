#include "sim.h"

#define MAX_ITERATIONS 50

static int colorBuf[SIM_Y_SIZE][SIM_X_SIZE];

static int calcMandelbrot(int cx, int cy) {
    int x = 0, y = 0;
    int iter = 0;
    
    const int SCALE = 1000;
    
    while (iter < MAX_ITERATIONS) {
        int x2 = (x * x) / SCALE;
        int y2 = (y * y) / SCALE;
        
        // Условие выхода |z| > 2
        if (x2 + y2 > 4 * SCALE) break;
        
        int temp = (x2 - y2) + cx;
        y = (2 * x * y) / SCALE + cy;
        x = temp;
        
        iter++;
    }
    
    return iter;
}

static int iter2Color(int iter) {
    if (iter == MAX_ITERATIONS)
    { return 0xFF000000; }
    
    int r = (iter * 12) % 256;
    int g = (iter * 7) % 256;
    int b = (iter * 3) % 256;
    
    return 0xFF000000 | (r << 16) | (g << 8) | b;
}

static void calcFrame(int scale, int centerX, int centerY) {
    for (int y = 0; y < SIM_Y_SIZE; ++y) {
        for (int x = 0; x < SIM_X_SIZE; ++x) {
            int cx = ((x - SIM_X_SIZE / 2) * scale) / (SIM_X_SIZE * 100) + centerX;
            int cy = ((y - SIM_Y_SIZE / 2) * scale) / (SIM_Y_SIZE * 100) + centerY;
            
            int iter = calcMandelbrot(cx, cy);
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
    // start point
    int startCenterX = -500;
    int startCenterY = 0;
    int startScale = 400000;
    
    // end point
    int endCenterX = -750;
    int endCenterY = 100;
    int endScale = 10000;
    
    const int TOTAL_STEPS = 500;
    
    for (int step = 0; step <= TOTAL_STEPS; ++step) {
        // zooming
        int currentCenterX = startCenterX + ((endCenterX - startCenterX) * step) / TOTAL_STEPS;
        int currentCenterY = startCenterY + ((endCenterY - startCenterY) * step) / TOTAL_STEPS;
        int currentScale   = startScale   + ((endScale   - startScale  ) * step) / TOTAL_STEPS;
        
        calcFrame(currentScale, currentCenterX, currentCenterY);        
        drawFrame();
        
        // delay
        // for (volatile int i = 0; i < 100000; ++i) {}
    }
}
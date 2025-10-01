#pragma once

#define SIM_X_SIZE 800
#define SIM_Y_SIZE 600

void simInit();
void app();
void simExit();
void simFlush();
void simPutPixel(int x, int y, int argb);
int simRand();
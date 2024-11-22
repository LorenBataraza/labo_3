#include "led.h"

#include <stdint.h>
#include <math.h>

#include "main.h"
#include "gamma.h"


RGB_t frame[WIDTH*HEIGHT];
uint8_t buffer1[WIDTH*BITS_PER_CHANNEL*SCAN_RATE];
uint8_t buffer2[WIDTH*BITS_PER_CHANNEL*SCAN_RATE];

float mapf(float value, float c_min, float c_max, float t_min, float t_max) {
	float res = (value - c_min) / (c_max - c_min) * (t_max - t_min) + t_min;
    return res;
}

float bound(float value, float max, float min) {
    return fmaxf(fminf(value, max), min);
}


void LED_fillBuffer(RGB_t *frame, uint8_t *buffer) {
    uint32_t i = 0, p1, p2;
    uint8_t bit, mask;
    for(uint8_t row = 0; row < SCAN_RATE; row++) {
        p1 = row * WIDTH;
        p2 = p1 + WIDTH * SCAN_RATE;
        for(bit = 0; bit < BITS_PER_CHANNEL; bit++) {
            mask = 1<<bit;
            for(uint8_t col = 0; col < WIDTH; col++) {
                buffer[i] =
                    ((((gammaR[frame[p2+col].R]) & mask) >> bit) << 5) |
                    ((((gammaG[frame[p2+col].G]) & mask) >> bit) << 4) |
                    ((((gammaB[frame[p2+col].B]) & mask) >> bit) << 3) |
                    ((((gammaR[frame[p1+col].R]) & mask) >> bit) << 2) |
                    ((((gammaG[frame[p1+col].G]) & mask) >> bit) << 1) |
                    ((((gammaB[frame[p1+col].B]) & mask) >> bit) << 0);
                i++;
            }
        }
    }
}




/*
// Sería mejor que escriba al buffer directamente, así salteamos usar fillBuffer.

void LED_fast_rectangle(uint8_t *buffer, RGB_t color, uint8_t min_row, uint8_t max_row, uint8_t min_col, uint8_t max_col){
    // Limitar los valores a los rangos del marco
    if (min_col >= WIDTH) min_col = WIDTH - 1;
    if (max_col >= WIDTH) max_col = WIDTH - 1;
    if (min_row >= HEIGHT) min_row = HEIGHT - 1;
    if (max_row >= HEIGHT) max_row = HEIGHT - 1;

    // La funcionalidad es la misma que fillBuffer pero cambian los límites nomás
    uint32_t i = 0, p1, p2;
    uint8_t bit, mask;

    // Convierto RGB_t a la estructura del buffer {0xRR, 0xGG, 0xBB}
    // Tengo color {}
    uint8_t aux_red= gammaR[color.R];
    uint8_t aux_green = gammaG[color.G];
    uint8_t aux_blue = gammaB[color.B];

    for(uint8_t row = min_row; row < max_row; row++) {
        p1 = row * WIDTH;
        p2 = p1 + WIDTH * SCAN_RATE;
        for(bit = 0; bit < BITS_PER_CHANNEL; bit++) {
            mask = 1<<bit;
            for(uint8_t col = min_col; col < max_col; col++) {
                buffer[i] = (((aux_red & mask) >> bit) << 5) |
                    (((aux_green & mask) >> bit) << 4) |
                    (((aux_blue & mask) >> bit) << 3) |
                    (((aux_red & mask) >> bit) << 2) |
                    (((aux_green & mask) >> bit) << 1) |
                    (((aux_blue & mask) >> bit) << 0);
                i++;
            }
        }
    }
}
*/


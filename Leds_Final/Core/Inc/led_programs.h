#pragma once
#include <stdint.h>
#include "led.h"

void LED_waveEffect(RGB_t *frame);
void LED_plasmaEffect(RGB_t *frame);
void LED_rectangle(RGB_t *frame, RGB_t color, uint8_t min_row, uint8_t max_row, uint8_t min_col, uint8_t max_col);
void LED_analog_bar(RGB_t *frame, RGB_t color_1, RGB_t color_2, float percentage);
void LED_Letter(RGB_t *frame, uint8_t * letter, uint8_t x_i, uint8_t y_i, RGB_t color, uint8_t circular);

typedef enum {wave=0, plasma, img1, img2, adc, text, slidding_text, falling_sand, total_programs} programs_t;


void LED_Text(
    RGB_t *frame, 
    uint8_t **font, 
    const char *str, 
    uint8_t x_i, 
    uint8_t y_i, 
    RGB_t color, 
    uint8_t enable_line_wrap
); 

void LED_SliddingText(
    RGB_t *frame, 
    uint8_t **font, 
    const char *str, 
    uint8_t x_i, 
    uint8_t y_i, 
    RGB_t color, 
    uint8_t enable_line_wrap,
    uint8_t direction
);

void LED_FallingSand(RGB_t *frame);

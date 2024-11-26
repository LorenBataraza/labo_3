#include <stdint.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
#include "led.h"
#include "led_programs.h"

void LED_waveEffect(RGB_t *frame) {
    static float time;
    float xx;
    uint8_t r, g, b;

    if(time > 2*M_PI) {
        time = 0.0;
    }

    for(uint8_t y = 0; y < HEIGHT; y++) {
        for(uint8_t x = 0; x < WIDTH; x++) {
            xx = mapf(x, 0, WIDTH-1, 0, 2*M_PI);
            r = 16 + 100 * (bound(sinf(xx + time + 2*M_PI/3), 0.5, -0.5) + 0.5);
            g = 16 + 100 * (bound(sinf(xx + time - 2*M_PI/3), 0.5, -0.5) + 0.5);
            b = 16 + 100 * (bound(sinf(xx + time         ), 0.5, -0.5) + 0.5);
            PIXEL(frame, x, y).R = r;
            PIXEL(frame, x, y).G = g;
            PIXEL(frame, x, y).B = b;
        }
    }
    time += 0.1;
}

void LED_plasmaEffect(RGB_t *frame) {
    static float time;
    uint8_t r, g, b;
    float xx, yy;
    float v;
    float delta = 0.025;

    time += 0.025;
    if(time > 12*M_PI) {
        delta *= -1;
    }

    for(uint8_t y = 0; y < HEIGHT; y++) {
        yy = mapf(y, 0, HEIGHT-1, 0, 2*M_PI);
        for(uint8_t x = 0; x < WIDTH; x++) {
            xx = mapf(x, 0, WIDTH-1, 0, 2*M_PI);

            v = sinf(xx + time);
            v += sinf((yy + time) / 2.0);
            v += sinf((xx + yy + time) / 2.0);
            float cx = xx + .5 * sinf(time/5.0);
            float cy = yy + .5 * cosf(time/3.0);
            v += sinf(sqrtf((cx*cx+cy*cy)+1)+time);
            v /= 2.0;
            r = 255 * (sinf(v * M_PI) + 1) / 2;
            g = 255 * (cosf(v * M_PI) + 1) / 2;
            b = 128 * (sinf(v * M_PI + 2*M_PI/3) + 1) / 2;
            PIXEL(frame, x, y).R = r;
            PIXEL(frame, x, y).G = g;
            PIXEL(frame, x, y).B = b;
        }
    }
}

void LED_Image(RGB_t *frame, RGB_t *image_to_copy){
    for (uint8_t row = 0; row <= WIDTH; row++) {
        for (uint8_t col = 0; col <= HEIGHT; col++) {
            // Calculamos la posición en el frame
            uint32_t index = row * WIDTH + col;
            // Establecemos el color en el frame
            frame[index] = image_to_copy[index];
        };
    };
}

void LED_rectangle(RGB_t *frame, RGB_t color, uint8_t min_row, uint8_t max_row, uint8_t min_col, uint8_t max_col){
 // Limitar los valores a los rangos del marco
    if (min_col >= WIDTH) min_col = WIDTH - 1;
    if (max_col >= WIDTH) max_col = WIDTH - 1;
    if (min_row >= HEIGHT) min_row = HEIGHT - 1;
    if (max_row >= HEIGHT) max_row = HEIGHT - 1;

    for (uint8_t row = min_row; row <= max_row; row++) {
        for (uint8_t col = min_col; col <= max_col; col++) {
            // Calculamos la posición en el frame
            uint32_t index = row * WIDTH + col;
            // Establecemos el color en el frame
            frame[index].R = color.R;
            frame[index].G = color.G;
            frame[index].B = color.B;
        };
    };
}

void LED_analog_bar(RGB_t *frame, RGB_t color_1, RGB_t color_2, float percentage) {
    // Asegurarnos de que 'percentage' está en el rango 0.0 - 1.0
    if (percentage < 0.0f) percentage = 0.0f;
    if (percentage > 1.0f) percentage = 1.0f;

    // Calcular la línea de separación
    uint32_t separation_line = (uint32_t)((1.0f - percentage) * HEIGHT);

    // Llenar con color_1 desde separation_line hasta la parte superior
    if (separation_line < HEIGHT) {
        LED_rectangle(frame, color_1, separation_line, HEIGHT - 1, 0, WIDTH - 1);
    }

    // Llenar con color_2 desde la parte inferior hasta separation_line
    if (separation_line > 0) {
        LED_rectangle(frame, color_2, 0, separation_line - 1, 0, WIDTH - 1);
    }
}


void LED_Letter(RGB_t *frame, uint8_t *letter, uint8_t x_i, uint8_t y_i, RGB_t color, uint8_t circular) {
    // Iteramos por cada píxel de la letra
    for (uint8_t x = 0; x < TEXT_WIDTH; x++) {
        for (uint8_t y = 0; y < TEXT_HEIGHT; y++) {
            int16_t frame_x = (circular)? (x+x_i)%WIDTH: x + x_i; // Posición x en el marco
            int16_t frame_y = y + y_i; // Posición y en el marco
            uint32_t letter_index = x + y * TEXT_WIDTH;

            // Si el píxel está dentro del marco, lo dibujamos
            if (frame_x >= 0 && frame_x < WIDTH && frame_y >= 0 && frame_y < HEIGHT) {
                uint32_t index = frame_x + frame_y * WIDTH;

                // Dibujamos solo si el píxel de la letra está activo
                if (letter[letter_index]) {
                    frame[index] = color; 
                } else {
                    frame[index] = (RGB_t){0x00, 0x00, 0x00};
                }
            }
        }
    }
}


void LED_Text(
    RGB_t *frame, 
    uint8_t **font, 
    const char *str, 
    uint8_t x_i, 
    uint8_t y_i, 
    RGB_t color, 
    uint8_t enable_line_wrap
) {
    uint8_t cursor_x = x_i;
    uint8_t cursor_y = y_i;

    // Iteramos sobre cada caracter en el string
    for (const char *c = str; *c != '\0'; c++) {
        // Ignoramos caracteres fuera del rango 'a' a 'z'
        if (*c < 'a' || *c > 'z') {
            continue;
        }

        // Accedemos a la matriz correspondiente al carácter desde el font
        uint8_t *letter = font[*c - 'a'];

        // Dibujamos la letra en la posición actual
        LED_Letter(frame, letter, cursor_x, cursor_y, color,0);

        // Movemos el cursor para la próxima letra
        cursor_x += TEXT_WIDTH + 1; // Espacio entre letras

        // Si la letra excede el ancho del frame
        if (cursor_x + TEXT_WIDTH > WIDTH) {
            if (enable_line_wrap) {
                // Salto de línea si está habilitado
                cursor_x = x_i;
                cursor_y += TEXT_HEIGHT + 1; // Espacio entre líneas
            } else {
                // Detener impresión si no se permite el salto de línea
                break;
            }
        }

        // Salimos si excedemos los límites verticales
        if (cursor_y + TEXT_HEIGHT > HEIGHT) {
            break;
        }
    }
}


void LED_SliddingText(
    RGB_t *frame, 
    uint8_t **font, 
    const char *str, 
    uint8_t x_i, 
    uint8_t y_i, 
    RGB_t color, 
    uint8_t enable_line_wrap,
    uint8_t direction
) {
    static uint32_t contador_frames =0;
    uint32_t frames_por_desplazamiento = 6;
    uint8_t desplazamiento = (uint8_t)(contador_frames/frames_por_desplazamiento)*direction;
    
    uint8_t cursor_x = x_i;
    uint8_t cursor_y = y_i;
    uint8_t cursor_actual;

    // Iteramos sobre cada caracter en el string
    for (const char *c = str; *c != '\0'; c++) {
        // Ignoramos caracteres fuera del rango 'a' a 'z'
        if (*c < 'a' || *c > 'z') {
            continue;
        }

        // Accedemos a la matriz correspondiente al carácter desde el font
        uint8_t *letter = font[*c - 'a'];
        
        // Si el cursor sobresale hay que traerlo devuelta
        cursor_actual = (cursor_x+desplazamiento)%WIDTH;
        // Dibujamos la letra en la posición actual
        LED_Letter(frame, letter, cursor_actual, cursor_y, color,1);

        // Movemos el cursor para la próxima letra
        cursor_x += TEXT_WIDTH + 1; // Espacio entre letras

        // Si la letra excede el ancho del frame
        if (cursor_x + TEXT_WIDTH > WIDTH) {
            if (enable_line_wrap) {
                // Salto de línea si está habilitado
                cursor_x = x_i;
                cursor_y += TEXT_HEIGHT + 1; // Espacio entre líneas
            } else {
                // Detener impresión si no se permite el salto de línea
                break;
            }
        }

        // Salimos si excedemos los límites verticales
        if (cursor_y + TEXT_HEIGHT > HEIGHT) {
            break;
        }
    }
    contador_frames++;
}


void LED_FallingSand(RGB_t *frame) {
    RGB_t *frame_auxiliar = (RGB_t *)malloc(WIDTH * HEIGHT * sizeof(RGB_t));

    if (frame_auxiliar == NULL) {
        return;
    }

    memcpy(frame_auxiliar, frame, WIDTH * HEIGHT * sizeof(RGB_t));

    uint16_t estado_actual[WIDTH * HEIGHT];
    int16_t siguiente_estado[WIDTH * HEIGHT];
    uint32_t index;

    memset(estado_actual, 0, sizeof(estado_actual));
    memset(siguiente_estado, -1, sizeof(siguiente_estado));

    for (uint8_t row = 0; row < HEIGHT; row++) {
        for (uint8_t col = 0; col < WIDTH; col++) {
            index = row * WIDTH + col;
            estado_actual[index] = (frame[index].R || frame[index].G || frame[index].B) ? 1 : 0;
        }
    }
    // Inicializar las matrices de estado
    for (uint8_t row = 0; row < HEIGHT; row++) {
        for (uint8_t col = 0; col < WIDTH; col++) {
            index = row * WIDTH + col;
            if (frame[index].R == 0 && frame[index].G == 0 && frame[index].B == 0) {
                estado_actual[index] = 0;  // No hay grano en esta posición
            } else {
                estado_actual[index] = 1;  // Hay un grano en esta posición
            }
            siguiente_estado[index] = -1;  // Inicializamos con -1, indicando que el grano no se ha movido
        }
    }

    // Realiza la simulación
// Inicializar la última fila en `siguiente_estado`
for (int col = 0; col < WIDTH; col++) {
    int index = (HEIGHT - 1) * WIDTH + col;
    if (estado_actual[index] == 1) {
        siguiente_estado[index] = index; // Mantener el grano en la última fila
    }
}

// Fase 2: Calcular el siguiente estado
for (int row = HEIGHT - 2; row >= 0; row--) {  // Recorrer de abajo hacia arriba
    for (int col = 0; col < WIDTH; col++) {
        int current_index = row * WIDTH + col;

        // Si el grano de arena está presente en el estado_actual
        if (estado_actual[current_index] == 1) {
            // Verificar si el espacio de abajo está libre
            int abajo_index = (row + 1) * WIDTH + col;
            if (estado_actual[abajo_index] == 0) {
                // Mover el grano de arena hacia abajo
                siguiente_estado[abajo_index] = current_index;
                estado_actual[current_index] = 0;
            } else {
                // Intentar mover hacia abajo a la izquierda o derecha
                int abajoIzquierda_index = (row + 1) * WIDTH + (col - 1);
                if (col > 0 && estado_actual[abajoIzquierda_index] == 0) {
                    siguiente_estado[abajoIzquierda_index] = current_index;
                    estado_actual[current_index] = 0;
                } else {
                    int abajoDerecha_index = (row + 1) * WIDTH + (col + 1);
                    if (col < WIDTH - 1 && estado_actual[abajoDerecha_index] == 0) {
                        siguiente_estado[abajoDerecha_index] = current_index;
                        estado_actual[current_index] = 0;
                    } else {
                        // Si no puede moverse, se queda en su posición actual
                        siguiente_estado[current_index] = current_index;
                    }
                }
            }
        }
    }
}

    // Ahora, calculamos el frame final con la información de siguiente_estado
    for (uint8_t row = 0; row < HEIGHT; row++) {
        for (uint8_t col = 0; col < WIDTH; col++) {
            index = row * WIDTH + col;
            if (siguiente_estado[index] != -1) {
                uint32_t origin_index = siguiente_estado[index];
                frame[index] = frame_auxiliar[origin_index];  // El grano se mueve a la nueva posición
            } else {
                frame[index] = (RGB_t){0x00, 0x00, 0x00};  // Si no se mueve, queda vacío
            }
        }
    }
    free(frame_auxiliar);
}


void LED_Video(uint8_t *nextBuffer, RGB_t** video, uint32_t cantidad_frames){
    static uint32_t current_frame =0;
    LED_fillBuffer(video[current_frame], nextBuffer);
    current_frame = (current_frame+1)%cantidad_frames;
}

// Aplico un cambio
void LED_ApplyChanges(RGB_t *frame, frame_diff_t *frame_diference){
    // Recorro todos los cambios
    for (size_t i = 0; i < frame_diference->cantidad_de_cambios; i++){
        uint16_t indice_actual = frame_diference->array_cambios_pixeles[i].index;
        frame[indice_actual]=  frame_diference->array_cambios_pixeles[i].nuevo_valor;
    }
    
}

void LED_VideoByFrameChanges(RGB_t *frame, const video_by_changes_t* video){
    static uint32_t current_frame =0;
    if(current_frame==0){
        LED_Image(frame, video->frame_inicial);
    }else{
    	LED_ApplyChanges(frame, &video->array_diferencias_frames[current_frame-1]);
    }
    current_frame = (current_frame+1)%video->cantidad_de_frames;
    HAL_Delay(video->duracion_ms/video->cantidad_de_frames);
}

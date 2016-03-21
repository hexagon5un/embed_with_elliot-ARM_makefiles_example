#include "stm32f4xx_hal.h"

#define LED4_PIN                         GPIO_PIN_12
#define LED3_PIN                         GPIO_PIN_13
#define LED2_PIN                         GPIO_PIN_14
#define LED1_PIN                         GPIO_PIN_15
#define LED_GPIO_PORT                   GPIOD

int main(void)
{
    GPIO_InitTypeDef   GPIO_InitStructure;

    HAL_Init();

    /* Enable GPIOD clock */
    __HAL_RCC_GPIOD_CLK_ENABLE();

    /* Configure PD12 pin as output */
    GPIO_InitStructure.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStructure.Pin = LED1_PIN | LED2_PIN | LED3_PIN | LED4_PIN;
    GPIO_InitStructure.Pull = GPIO_PULLUP;
    GPIO_InitStructure.Speed = GPIO_SPEED_FAST;
    HAL_GPIO_Init( LED_GPIO_PORT , &GPIO_InitStructure);

    while(1) {
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED4_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED3_PIN, GPIO_PIN_RESET);
        HAL_Delay(400);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED1_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED4_PIN, GPIO_PIN_RESET);
        HAL_Delay(400);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED2_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED1_PIN, GPIO_PIN_RESET);
        HAL_Delay(400);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED3_PIN, GPIO_PIN_SET);
        HAL_GPIO_WritePin(LED_GPIO_PORT, LED2_PIN, GPIO_PIN_RESET);
        HAL_Delay(400);
    }
}

void SysTick_Handler(void) {
    HAL_IncTick();
}

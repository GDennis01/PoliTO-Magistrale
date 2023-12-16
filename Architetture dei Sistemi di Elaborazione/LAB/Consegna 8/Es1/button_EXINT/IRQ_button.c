#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"
signed char counter=0;
void EINT0_IRQHandler (void)	  
{
	counter = 0;
  LED_Out(counter);
	LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	LED_Out(counter++);
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
  LED_Out(counter--);
	LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}



#include <avr/io.h>
#include <math.h>
#include <stdio.h>
#include "image.h"
#include<avr/interrupt.h>

int ShaftCountLeft=0,ShaftCountRight=0;

void Init_Ports ()
{
	DDRA = 0x0f;
	PORTA = 0x06;
	DDRL = 0x18;
	PORTL = 0x18;
	DDRE = 0x00;

}
void left_position_encoder_interrupt_init ()
{
	
	cli();
	EICRB = EICRB | 0x02;
	EIMSK = EIMSK | 0x10;
	sei();
}

void right_position_encoder_interrupt_init ()
{
	
	cli();
	EICRB = EICRB | 0x08;
	EIMSK = EIMSK | 0x20;
	sei();
}

void stop()
{
	PORTA= 0x00;
}


void Init_Interrupt()
{

	left_position_encoder_interrupt_init();
	right_position_encoder_interrupt_init ();
}

ISR(INT5_vect)
{
	ShaftCountRight++;
}


ISR(INT4_vect)
{
	ShaftCountLeft++;
}

void linear_distance_mm(unsigned int DistanceInMM)
{
 
	float ReqdShaftCount = 0;
	unsigned long int ReqdShaftCountInt = 0;
  	ReqdShaftCount = DistanceInMM / 5.338; 	// division by resolution to get shaft count
	ReqdShaftCountInt = (unsigned long int) ReqdShaftCount;
	ShaftCountRight = 0;
	while(1)
	 	{
		  		if(ShaftCountRight > ReqdShaftCountInt)
				 		 {
						   		break;
						  }	 
		}  stop(); //Stop action
}

void angle_rotate(unsigned int Degrees)
{
    float ReqdShaftCount = 0;
	unsigned long int ReqdShaftCountInt = 0;
	ReqdShaftCount = (float) Degrees/ 4.090; // division by resolution to get shaft count
	ReqdShaftCountInt = (unsigned int) ReqdShaftCount;
	ShaftCountRight = 0; //defined globle variable
	ShaftCountLeft = 0;
	while (1)
	  {  
	      if((ShaftCountRight >= ReqdShaftCountInt) | (ShaftCountLeft >= ReqdShaftCountInt))
		        break;
	  }   
	stop(); //Stop action
}

void Left()
{
	PORTA=0x05;
}
void Right()
{
	PORTA = 0x0a;
}

void Forward()
{
	PORTA= 0x06;
}
/*int calDir (int i)
{
	float y2 = arr[i+1][1],x2 = arr[i+1][0],y1 = arr[i][1],x1 = arr[i][0],y0 = arr[i-1][1],x0 = arr[i-1][0];
	if (y1 > y0)
	{
		if ((y1-y0)*x2 - (x1-x0)*y2 > (y1-y0)*x0 - (x1-x0)*y0)
			return 1;
		else 
			return 0;
	}
	else
	{
		if ((y1-y0)*x2 - (x1-x0)*y2 > (y1-y0)*x0 - (x1-x0)*y0)
			return 0;
		else 
			return 1;
	}
}
float calAngle (int i)
{
	float dot, p1,q1,p2,q2,mod1,mod2, angle;
	float y2 = arr[i+1][1],x2 = arr[i+1][0],y1 = arr[i][1],x1 = arr[i][0],y0 = arr[i-1][1],x0 = arr[i-1][0];
	p1 = x1 - x0;
	q1 = y1 - y0;
	p2 = x2 - x1;
	q2 = y2 - y1;
	dot = p1*p2 + q1*q2;
	mod1 = sqrt(p1*p1 + q1*q1);
	mod2 = sqrt(p2*p2 + q2*q2);
	dot = dot/((mod1)*(mod2));
	angle = acos(dot)*(180)/3.14;
	return angle;
}
float calDist (int i)
{
	float dist, y2 = arr[i+1][1],x2 = arr[i+1][0],y1 = arr[i][1],x1 = arr[i][0],y0 = arr[i-1][1],x0 = arr[i-1][0];
	dist = sqrt((y2-y1)*(y2-y1) + (x2-x1)*(x2-x1));
	return 3 * dist;
}*/
void motion_set()
{
	int i;
	for (i = 0; i < m;i++)
	{
		if (arr[i][1] == 2)
		{
			Left();
			angle_rotate(arr[i][1]);
		}
		else if (arr[i][1] == 0)
		{
			Right();
			angle_rotate(arr[i][2]);
		}
		Forward();
		linear_distance_mm(arr[i][3]);
	}
}

void main ()
{
	Init_Ports();
	Init_Interrupt();
	motion_set();
}

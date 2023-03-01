#ifndef LoadCell_H_
#define LoadCell_H_

#include <SimpleFOC.h>

float readLoadCell(int ch);
void calibrateLinear(BLDCMotor *LIN_MOTOR); 
void initLoadCell();

#endif // LoadCell_H_
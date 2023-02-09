#ifndef LoadCell_H_
#define LoadCell_H_

#include <SimpleFOC.h>

float readLoadCell();
void calibrateLinear(BLDCMotor *LIN_MOTOR); 
void initLoadCell();

#endif // LoadCell_H_
/// @description Coverts decimals to regular numbers
//Example: 0.1 becomes 1
var number = argument0;
var number_frac = frac(number);

if number_frac >= 0.10
return number_frac*10;

else
if number_frac < 0.10
return number_frac*20;


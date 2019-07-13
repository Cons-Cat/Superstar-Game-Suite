var range = argument[0];
var num = 0;

switch(argument_count){
    case 2:
        num = argument[1];
        break;
    case 3:
        num = argument[1] + argument[2] * 65536;
        break;
}


var seed = round(random_range(1000000,10000000)) + num;

random_set_seed(seed);
rand = irandom_range(0,range);

return round(rand);

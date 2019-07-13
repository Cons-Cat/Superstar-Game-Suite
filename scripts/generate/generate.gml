for(var i = 0; i < argument[0]; i++){
    for(var j = 0; j < argument[1]; j++){
        var zz = getPerlinNoise_2D(i,j,100);
        grid[# i,j] = zz;
    }
}

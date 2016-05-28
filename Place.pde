class Place {
 int postalcode;
 String name;
 float x;
 float y;
 float population;
 float density;
 boolean drawFlag; //check if the city is drawn or not currently
 boolean highlighted;
 
 Place(int p, String n, float xc, float yc, float po, float de, boolean hi){
   postalcode = p;
   name = n;
   x = xc;
   y = yc;
   population = po;
   density = de;
   highlighted = hi;
   drawFlag = false;
 }
 
 void draw(){    
    noStroke();      
    if(highlighted == true){
        fill(225, 0, 0, 100);
        ellipse((int)mapX(x),(int)mapY(y), radius(population),  radius(population));
        fill(225, 0, 0, 225);
        text(name,(int)mapX(x) + radius(population),(int)mapY(y) + radius(population));
        fill(102, 102, 102);
        text("Postal code: " + postalcode, 600, 280);
        text("Population: " + int(population), 600, 300);        
    }else if(highlighted == false){
        fill(0, 0, 225, 100);
        ellipse((int)mapX(x),(int)mapY(y), radius(population),  radius(population));
    }
    drawFlag = true;   
 }
 
boolean contains(int px, int py) {
    // Since we draw a circle, we use here the distance between (px, py) and the circle's center.
    // We add an extra pixel to facilitate mouse picking.
    if(drawFlag == true){
    return dist(mapX(x), mapY(y), px, py) <= radius(population);
    } else{
      return false;
    }
}
 
float mapX(float x){
    return map(x, minX, maxX, 0, 600);
}

float mapY(float y){
    return map(y, minY, maxY, 650, 50);
}

float radius(float p){
   return map(p, minPopulation, maxPopulation, 1, 100);
}
}
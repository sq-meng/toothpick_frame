$fn=51;
module testBoard(d_center=6, step=0.1, no=5){
    difference(){
        cube([d_center * no + 2.5 * (no + 1), 5, d_center + 4]);
        for (i=[0:no-1]){
            d_start = d_center - step * (no - 1) / 2;
            d = d_start+step*i;
            echo(d);
            translate([(d_center + 2.5)*i + d_center/2+ 2, -0.01, d_center/ 2 + 2])
              rotate(-90, [1, 0, 0])
              cylinder(d=d, h=20);
            }
        }
cube([d_center * no + 2.5 * (no + 1), 8, 1]);
}

testBoard();

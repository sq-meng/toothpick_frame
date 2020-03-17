d1=2;
th_d=1.2;
$fn=31;

module tube_i(offset, axes){
    translate([offset, 0, 0])
    rotate(-30, axes)
    cylinder(d=d1, h=30, center=true);}


module tube_o(offset, axes){
    translate([offset, 0, 0])
    rotate(-30, axes)
    cylinder(d=d1+th_d*2, h=20, center=true);
}


difference(){
    intersection(){
        union(){
        hull(){
            intersection(){
                union()
                {
                tube_o(-7.5, [1, 1, 0]);
                tube_o(7.5,[1, -1, 0]);
                }
                translate([0, 0, 0.6])cube([50, 50, 1.2], center=true);
                
            }
            translate([0, -5, 0])cylinder(d=6.4, h=1.2);
        }
        tube_o(-7.5, [1, 1, 0]);
        tube_o(7.5,[1, -1, 0]);
        }
        translate([0, 0, 25])cube([50, 50, 50], center=true);
    }
    tube_i(-7.5, [1, 1, 0]);
    tube_i(7.5,[1, -1, 0]);
    translate([0, -5, 0])cylinder(d=3.2, h=5, center=true);

}
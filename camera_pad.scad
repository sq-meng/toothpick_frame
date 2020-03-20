$fn = 31;
hole = 3.2;
pad = 1.6;
th = 1.6;
md = 30.5;
m1 = 32.532 - md / 2;
pad_th = 1;

difference(){
    hull(){
        translate([0, m1, 0])cylinder(d=hole + pad * 2, h=th);
        translate([-md/2, 0, 0])cylinder(d=hole + pad * 2, h=th);
        translate([md/2, 0, 0])cylinder(d=hole + pad * 2, h=th);
        }
    translate([0, m1, 0])cylinder(d=hole, h=th*3, center=true);
    translate([-md/2, 0, 0])cylinder(d=hole, h=th*3, center=true);
    translate([md/2, 0, 0])cylinder(d=hole, h=th*3, center=true);
    hull(){
        l1=7;
        l2=3;
        d=8;
        translate([-l1, -l2, 0])cylinder(d=d, h=10, center=true);
        translate([l1, -l2, 0])cylinder(d=d, h=10, center=true);   
        }
    translate([0, m1, pad_th])cylinder(d=hole + pad * 2.5, h=th);
    translate([-md/2, 0, pad_th])cylinder(d=hole + pad * 2.5, h=th);
    translate([md/2, 0, pad_th])cylinder(d=hole + pad * 2.5, h=th);
    translate([0, 6, 0])cylinder(d=2.2, h=10, center=true);
}
include <sq.scad>

h=3;
hpad=1.8;
dscrew=2.2;


$fn=21;
module t1(s=1){
    translate([-10 * s, 0, 0])children();
    }

module t2(){
    translate([0, 9, 0])
    rotate(60, [0, 0, -1])
    rotate(50, [1, 0, 0])
    
    children();
    }

module rod(d=6, round=0.6, h=40){
    //cylinder(d1=d, d2=d, h=h, center=true);
    hull(){
        for (i=[0:5]){
            rotate(60 * i, [0, 0, 1])
            translate([-(d/2 - round/2), (d/2 - round/2) * tan(30), 0])
            cylinder(d=round, h=h, center=true);
            }
        }
    }

module cutout(d=3){
    cylinder(d=d, h=70, center=true);
    //translate([-1.5, -3, 0])cube([6, 6, 80], center=true);
    //translate([0, -4, 0])cylinder(d=8, h=80, center=true);
    translate([0, -5, 0])cube([1, 10, 80], center=true);
    }
    
module cutout2(){
    translate([-5, 0, 0])cube([10, 10, 80], center=true);
    }

module main(){
difference(){
    union(){
        t1()t2()rod();
        mirror([1, 0, 0])t1()t2()rod();
        sequentialHull(){
            intersection(){
                cylinder(d=200, h=h+1);
                t1()t2()
                difference(){
                    rod();
                    cutout();
                    cutout2();
                    }
                }
                        intersection(){
                cylinder(d=200, h=h);t1()translate([0, 0, -1])sphere(d=7);
                        }
                        intersection(){
                cylinder(d=200, h=h);mirror([1, 0, 0])t1()translate([0, 0, -1])sphere(d=7);}
            mirror([1, 0, 0])
                
                intersection(){
                cylinder(d=200, h=h+1);
           t1()t2()difference(){
                    rod();
                    cutout();
                    cutout2();
                    }
            }
       }
    }
    t1()t2()cutout();
    mirror([1, 0, 0])t1()t2()cutout();
    t1()translate([0, 0, hpad])cylinder(d=4.2, h=5);
    mirror([1, 0, 0])t1()translate([0, 0, hpad])cylinder(d=4.2, h=5);
    translate([0, 0, -99.99])cylinder(d=100, h=100);
    t1()cylinder(d=dscrew, h=5, center=true);
    t1(-1)cylinder(d=dscrew, h=5, center=true);
}
}

main();
//hull(){
//translate([0, 7, 1])cube([6,5,2], center=true);
//translate([0, 0, 20])cube([40,2,2], center=true);
//}
module ctest(){
    difference(){
        rod();
        cutout();
        cutout2();
        }
    }

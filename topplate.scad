$fn=31;
w = 33;
h = 33;
hd = 30.5;
t=1.6;
w_gps = 14;
h_gps = 22;

module corner(){
    cylinder(h=t, d=6);
    }
module screwhole(){
    translate([0, 0, -0.01])cylinder(h=10, d=3.3);
    }

module screwholes(){
    translate([-hd/2, -hd/2, 0])screwhole();
    translate([-hd/2, hd/2, 0])screwhole();
    translate([hd/2, -hd/2, 0])screwhole();
    translate([hd/2, hd/2, 0])screwhole();
    translate([0, 13, 0])cylinder(d=2.5, h=10, center=true);
    }

module recess(){
    translate([0, 0, 1])cylinder(h=5, d=6);
    }
    
module recesses(){
    translate([-hd/2, -hd/2, 0])recess();
    translate([-hd/2, hd/2, 0])recess();
    translate([hd/2, -hd/2, 0])recess();
    translate([hd/2, hd/2, 0])recess();
    }
difference(){
    hull(){
        translate([-w/2, -h/2, 0])corner();
        translate([-w/2, h/2, 0])corner();
        translate([w/2, -h/2, 0])corner();
        translate([w/2, h/2, 0])corner();
        }
    screwholes();
    recesses();
}

hull(){
    translate([-w_gps/2, 0, 0])cylinder(d=3, h=t);
    translate([w_gps/2, 0, 0])cylinder(d=3, h=t);
    translate([-w_gps/2, -h/2 -h_gps/2, 0])cylinder(d=3, h=t);
    translate([w_gps/2, -h/2 -h_gps/2, 0])cylinder(d=3, h=t);
    }
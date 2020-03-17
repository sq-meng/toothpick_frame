screw_hole = 2.1;
w = 14;
h = 11;
t = 1.6;

$fn=31;

module rod(){
    translate([-h, 1, 0])rotate(90, [1, 0, 0])cylinder(d=t, h=6, center=true);
    }

module side(){
    hull(){
        cylinder(d=screw_hole + 4, h=t, center=true);
        rod();
    }
}

rotate(-90, [0, 1, 0])
difference(){
union(){
    side();
    translate([0, 0, w + t])side();
    hull(){
        rod();
        translate([0, 0, w + t])rod();
        }
    }
cylinder(h=100, d=screw_hole, center=true);    
translate([0, 1, w/2 + t/2])rotate(90, [0, 1, 0])cylinder(h=100, d=screw_hole, center=true);
}
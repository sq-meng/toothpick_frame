$fn=51;
c = 30.5 / 2;
dy=9;
dx=8;
th = 1.6;
sink = -6;
module tab_c(){
    translate([-4.5, 0, 0])
      rotate(90, [1, 0, 0])
      cylinder(d=th, h=3+2.4, center=true);
    }
module tab(){
    difference(){
    hull(){
        cylinder(d=3+2.4, h=th, center=true);
        tab_c();
    }
        cylinder(d=3.1, h=3, center=true);
    }
    hull(){
        tab_c();
        translate([0, 0, sink])tab_c();
        }
    hull(){
        tab_c();
        translate([0, 0, -1])tab_c();
        translate([1, 0, 0])tab_c();
        }
    hull(){
        translate([-1.5, 0, 0])tab_c();
        translate([-1.5, 0, sink])tab_c();
        translate([0, 0, 0])tab_c();
        translate([0, 0, sink])tab_c();
        }
}

difference(){
union(){
    translate([c, c, 0])tab();
    translate([c, -c, 0])tab();
    mirror([1, 0, 0])translate([c, c, 0])tab();
    mirror([1, 0, 0])translate([c, -c, 0])tab();

    hull(){
        translate([c, c, sink])tab_c();
        mirror([1, 0, 0])translate([c, -c, sink])tab_c();
        }
        
    mirror([0, 1, 0])hull(){
        translate([c, c, sink])tab_c();
        mirror([1, 0, 0])translate([c, -c, sink])tab_c();
        }

        
    hull(){
        translate([dx, dy, sink])sphere(d=th);
        translate([dx, -dy, sink])sphere(d=th);
        translate([-dx, dy, sink])sphere(d=th);
        translate([-dx, -dy, sink])sphere(d=th);
        }    
    }
    //cube([6, 8, 15], center=true);    
}
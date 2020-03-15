$fn=51;
c = 30.5 / 2;
d=9;
module tab_c(){
    translate([-3, 0, 0])
      rotate(90, [1, 0, 0])
      cylinder(d=1, h=3+2.4, center=true);
    }
module tab(){
    difference(){
    hull(){
        cylinder(d=3+2.4, h=1, center=true);
        tab_c();
    }
        cylinder(d=3.1, h=3, center=true);
    }
    hull(){
        tab_c();
        translate([0, 0, -2])tab_c();
        }
}

difference(){
union(){
    translate([c, c, 0])tab();
    translate([c, -c, 0])tab();
    mirror([1, 0, 0])translate([c, c, 0])tab();
    mirror([1, 0, 0])translate([c, -c, 0])tab();

    hull(){
        translate([c, c, -2])tab_c();
        mirror([1, 0, 0])translate([c, -c, -2])tab_c();
        }
        
    mirror([0, 1, 0])hull(){
        translate([c, c, -2])tab_c();
        mirror([1, 0, 0])translate([c, -c, -2])tab_c();
        }

        
    hull(){
        translate([d, d, -2])sphere(d=1);
        translate([d, -d, -2])sphere(d=1);
        translate([-d, d, -2])sphere(d=1);
        translate([-d, -d, -2])sphere(d=1);
        }    
    }
    cube([12, 12, 15], center=true);    
}
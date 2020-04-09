$fn=31;

module motor_holder(d_pad=20, pad_thickness=4, hole_spacing=12, hole_dia=2.15, center_hole_dia=5, no_holes=4, hole_offset=45, rim_thickness=1, d_rim=24, spar_dia=5, dual_spar=true, spar_hor_spacing=15, spar_holder_thickness=2, spar_holder_length=10, spar_height=6, spar_backout=10)
{   
    echo("spar height from ", spar_height - spar_dia / 2, " to ", spar_height + spar_dia / 2);
    module spar_holders(){
        module holder(){cylinder(d=spar_dia + spar_holder_thickness * 2, h=spar_holder_length);}
        if (dual_spar){
            translate([-spar_hor_spacing/2, -spar_backout, spar_height])rotate(90, [1, 0, 0])holder();
            translate([spar_hor_spacing/2, -spar_backout, spar_height])rotate(90, [1, 0, 0])holder(); 
        } else {
            translate([0, -spar_backout, spar_height])rotate(90, [1, 0, 0])holder(); 
            }
        
    }
    module spar_cutouts(){
        module holder_cutout(){cylinder(d=spar_dia +0.2, h=spar_holder_length + 50, center=true);}
        if (dual_spar){
        translate([-spar_hor_spacing/2, -spar_backout, spar_height])rotate(90, [1, 0, 0])holder_cutout();
         translate([spar_hor_spacing/2, -spar_backout, spar_height])rotate(90, [1, 0, 0])holder_cutout(); }
         else{
       translate([0, -spar_backout, spar_height])rotate(90, [1, 0, 0])holder_cutout();  
         }
        }
    
    module body(){
        union(){
        hull(){
            spar_holders();
            difference(){
                cylinder(d=d_rim, h=pad_thickness+rim_thickness);
                translate([0, 20 ,0])cube([40, 40, 40], center=true);
            }
           }
    cylinder(d=d_rim, h=pad_thickness+rim_thickness);
        }
    }
    module center_hole_cutout(){
        cylinder(h=50, d=center_hole_dia, center=true);
        }
    module motor_hole_cutout(){
        for (i=[0:no_holes]){
            rotate(i*360/no_holes + hole_offset, [0, 0, 1])  
              translate([0, hole_spacing/2])
              cylinder(h=20, d=hole_dia, center=true);
            }
        }
    module between_cutout(){
        hull(){
            d=spar_hor_spacing - 2 * spar_holder_thickness;
            translate([0, -spar_backout - 4 - d/2, 0])
              cylinder(d=spar_hor_spacing - 2 * spar_holder_thickness - spar_dia, h = 20);
            translate([0, -spar_backout - 2 - d/2 - spar_holder_length, 0])
              cylinder(d=spar_hor_spacing - 2 * spar_holder_thickness - spar_dia, h = 20);
            
            }
        }
    difference(){
        body();
        spar_cutouts();
        translate([0, 0, pad_thickness])cylinder(d=d_pad, h=20);
        center_hole_cutout();
        motor_hole_cutout();
        if (dual_spar){
            between_cutout();
            }
        }
}

motor_holder();
$fn=41;
//$vpr = [90, 0, -45];
p_spar_dia = 6.18;
p_frame_size = 200;

p_dual_spar=false;
p_spar_heights = [8.2, 14.5, 8.2, 14.5];
p_pad_thickness=3;

module motor_holder(d_pad=20, pad_thickness=3, hole_spacing=12, hole_dia=2.15, center_hole_dia=5, no_holes=4, hole_offset=45, rim_thickness=0.6, d_rim=24, spar_dia=5, dual_spar=false, spar_hor_spacing=15, spar_holder_thickness=2, spar_holder_length=10, spar_height=7, spar_backout=10)
{   
    echo(str("spar height from ", spar_height - spar_dia / 2, " to ", spar_height + spar_dia / 2));
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
        module holder_cutout(){cylinder(d=spar_dia +0.2, h=spar_holder_length + 200, center=true);}
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



module fuselage(main_dia=56, h_thk=2, v_thk=5, mounting_holes_dia=[2, 3.2], fc_tab_v_thk=1.6, mounting_holes_pos=[20, 30.5], mount_hole_offset=45, spar_heights=[8, 14, 8, 14], spar_dia=5, spar_hor_spacing=15, dual_spar=false, arm_offset=45, spar_holder_extend=2, rim=true, rim_inner=2, rim_outer=2, rim_v_thk=1.6)
{
   module body(){
       cylinder(d=main_dia, h=v_thk);
       }
   module body_cutout(){
       cylinder(d=main_dia - h_thk * 2, h=v_thk*9, center=true);
       }
   module fc_tab(){
       difference(){
           intersection(){
               body();
               hull(){
                    translate([0, mounting_holes_pos[0]/2 * 1.4142, 0])cylinder(d=mounting_holes_dia[0] + 2.4, h=fc_tab_v_thk);
                    translate([8, mounting_holes_pos[0]/2 * 1.4142 + 20, 0])cylinder(d=mounting_holes_dia[0] + 2.4, h=fc_tab_v_thk);
                    translate([-8, mounting_holes_pos[0]/2 * 1.4142 + 20, 0])cylinder(d=mounting_holes_dia[0] + 2.4, h=fc_tab_v_thk);
               }
               }
           for (i=[0: len(mounting_holes_dia) -1]){
               translate([0, mounting_holes_pos[i]*1.4142 / 2, -1])cylinder(d=mounting_holes_dia[i], h=10);
               }
           }
       }
   module spar_holder(spar_height, spar_dia){
       module spar_cutouts(){
           if (dual_spar) {
               translate([spar_hor_spacing/2, 1, spar_height])rotate(-90, [1, 0, 0])cylinder(h=main_dia / 2 + spar_holder_extend, d=spar_dia);
               translate([-spar_hor_spacing/2, 1, spar_height])rotate(-90, [1, 0, 0])cylinder(h=main_dia / 2 + spar_holder_extend, d=spar_dia);
               } else {
               translate([0, 1, spar_height])rotate(-90, [1, 0, 0])cylinder(h=main_dia / 2 + spar_holder_extend, d=spar_dia);
               }
           }
       difference(){
           hull(){
               translate([0, main_dia/2, 1])cube([spar_dia + 4 + spar_height * 0.4, spar_holder_extend * 2 , 2], center=true);
               if (dual_spar){
                   translate([spar_hor_spacing/2, 0, spar_height])rotate(-90, [1, 0, 0])cylinder(h=main_dia / 2 + spar_holder_extend, d=spar_dia + 4);
                   translate([-spar_hor_spacing/2, 0, spar_height])rotate(-90, [1, 0, 0])cylinder(h=main_dia / 2 + spar_holder_extend, d=spar_dia + 4);
                   } else {
                   translate([0, 0, spar_height])rotate(-90, [1, 0, 0])cylinder(h=main_dia / 2 + spar_holder_extend, d=spar_dia + 4);
                   }
               }
           body_cutout();
           spar_cutouts();
       }
   }
   module rim(){
       difference(){
           cylinder(d=main_dia + rim_outer * 2, h=rim_v_thk);
           cylinder(d=main_dia - h_thk * 2 - rim_inner * 2, h=rim_v_thk * 2 + 1, center=true);
           }
       }
   difference(){
       body();
       body_cutout();
       }
   num = len(spar_heights);
   for (i=[0: 3]){
       rotate(i * 360/4 + mount_hole_offset, [0, 0, 1])fc_tab();
       }
   for (i=[0: num - 1]){
       rotate(i * 360/num + mount_hole_offset, [0, 0, 1])spar_holder(spar_heights[i], spar_dia);
       }
    if(rim) {rim();}
}


module spacer_bar(d_pad=20, main_dia=56, frame_size=200){
    translate([-0.8, main_dia/2, 0])cube([1.6, (frame_size - main_dia - d_pad) / 2 + 1, 1]);
    }

//fuselage(spar_heights=p_spar_heights, spar_dia=p_spar_dia, dual_spar=p_dual_spar);
module arms(){
for (i=[0:len(p_spar_heights) - 1]) {
    rotate(i*360/len(p_spar_heights) + 45)translate([0, p_frame_size/2, 0])motor_holder(spar_height=p_spar_heights[i], spar_dia=p_spar_dia, dual_spar=p_dual_spar, pad_thickness=p_pad_thickness);
    rotate(i*360/len(p_spar_heights) + 45)spacer_bar();
}
}

for (i=[0:len(p_spar_heights) - 1]){
    translate([30 * i, 0, 0])motor_holder(spar_height=p_spar_heights[i], spar_dia=p_spar_dia, dual_spar=p_dual_spar, pad_thickness=p_pad_thickness);
    }
//translate([100 / 1.414, 100 / 1.414, -10])cylinder(d=5*25.4, h=1);
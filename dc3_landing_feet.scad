$fn = 31;
module main(){
intersection(){
translate([0, 0, -3.5])
  hull(){
      translate([0, -5, 0])sphere(d=12);
      translate([0, 5, 0])sphere(d=12);
      };
translate([0, 0, 15])cube([30, 30, 30], center=true);    
}}

module arm(){
intersection(){
translate([0, 0, 2.5-3.69])
  hull(){
      translate([0, -4, 0])sphere(r=3.69);
      translate([0, 4, 0])sphere(r=3.69);
      };
translate([0, 0, 15])cube([30, 30, 30], center=true);    
    }
}

//main();
translate([-4, 0, 0])arm();
translate([4, 0, 0])arm();
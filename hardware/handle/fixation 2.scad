mm = 1;
scd=1.2*mm;//screw radius
part_thickness = 10*mm;
hl = 80*mm; //handle length

module part(){
    union(){
        //base disc
        cylinder(h=10*mm, r=20*mm, center=true);
        //handle
        translate([0,hl/2,0]) cube([40*mm,hl,10*mm], center=true);
        
        difference(){
            //main body of the grip
            translate([0,hl+25,5*mm]) cube([40*mm,50*mm,20*mm], center=true);
            
            //cradle to hold the pen in place
            translate([0,hl+20,10*mm]) rotate(45, [1,0,0]) cube([80*mm,12*mm,12*mm], center=true);
            
            //beveling cubes for the grip
            translate([0,hl,15.5*mm]) rotate(45, [1,0,0]) cube([80*mm,15*mm,15*mm], center=true);
            translate([0,hl+50,-5*mm]) rotate(45, [1,0,0]) cube([80*mm,15*mm,15*mm], center=true);
            
            //symetry of the cradle
            translate([0,hl+30,10*mm]) rotate(45, [1,0,0]) cube([80*mm,12*mm,12*mm], center=true);
            
            //join between the two cradles
            translate([0,hl+25,13*mm]) cube([80*mm,10*mm,23*mm], center=true);
            
            //screw hole
            translate([0,hl+80,10*mm]) rotate(90,[1,0,0]) cylinder(h=60*mm,r=scd);
            
            //nut holding slot
            translate([0,hl+45,10*mm]) cube([scd*6,scd*1.5,100],center=true);
        }
    }
}

module axis_1(){//28BYJ-48-08 stepper axis
    intersection(){
        rotate(180, [1,0,0]) cylinder(h=part_thickness*2,r=5*mm, center=true);
        rotate(90, [1,0,0]) cube([part_thickness+10*mm, part_thickness+10*mm, 3*mm], center=true);
    }
}

module handle(){
    difference(){
        part();
        axis_1();
    }
}

handle();
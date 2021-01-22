mm =1;//scale of the design
ht = 10*mm;//handle thickness


module axis_1(){//28BYJ-48-08 stepper axis
    intersection(){
        rotate(90, [0,1,0]) cylinder(h=ht*2,r=5, center=true);
        cube([ht*2, ht*2, 3], center=true);
    }
}

//overcomplicated, but it works
module handle(){
    difference(){
        intersection(){
            difference(){
                cylinder(h=ht, r=80*mm, center=true);
                translate([-27*mm,-15*mm,0]) cylinder(h=ht*2, r=60*mm, center=true);
                translate([-40*mm,75*mm,0]) cube([200*mm,20*mm,200*mm], center=true);
                translate([-70*mm,40*mm,0]) cube([100*mm,100*mm,ht*2], center=true);
            }
            union(){
                translate([56*mm,0*mm,0]) cylinder(h=ht*2,r=25*mm);
                translate([-40*mm,0*mm,0]) cube([200*mm,100*mm,ht*2]);
            }
        }
        //Change this line to change the axis hole
        translate([56*mm,-2*mm,0]) rotate(90, [0,1,0]) axis_1();
    }
}

handle();
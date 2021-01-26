mm = 1;//scale of the model (base unit)

//gear parameters
gear_teeth = 40;
gear_thickness = 8*mm;
ball_diameter = 2.5*mm;
links_length = 2*mm;
links_thickness = 0.5*mm;
groove_depth = 1.05;
vents = 5;
axis = [1,0,0];

//simple calculus
ball_radius = ball_diameter/2;
gear_radius = gear_teeth*(links_length+ball_diameter)/PI/2;
echo(gear_radius*2);

//module to create a cirle of balls (carve the teeth of the gear)
module circ(rad, nb){
    for (i = [0:nb-1]){
        rotate(i*360/nb, [0,1,0])
        translate( [rad, 0, 0] ) children(0);
    }
}

//module to create the gear body (ready to be carved)
module gear_body(){
    difference(){
        //main gear body
        union(){
            rotate(90, axis) cylinder(h=gear_thickness/2, r1=gear_radius, r2=gear_radius*groove_depth, center=false);
            rotate(270, axis) cylinder(h=gear_thickness/2, r1=gear_radius, r2=gear_radius*groove_depth, center=false);
            }
        
        difference(){
            //base body to carve the groove
            rotate(90, axis) cylinder(h=links_thickness*1.5, r=gear_radius*1.5, center=true);
            //secondary body to define the groove depth
            rotate(90, axis) cylinder(h=links_thickness*2, r=gear_radius-links_thickness*1.5, center=true);
        }
    }
}

//body without holes
module gear_full(){
    difference(){
        gear_body();
        circ(gear_radius, gear_teeth) sphere(r = ball_radius);
    }
}

//holes "vents" carved in the gear to discrease weight and PLA consumption
module gear_holes(){
    circ(gear_radius/2, vents) rotate(90, axis) cylinder(h=gear_thickness*2, r=gear_radius*PI/(vents*2.5), center=true);
}

//===========Axis Modules===========================
module axis_1(){//28BYJ-48-08 stepper axis
    intersection(){
        rotate(90, axis) cylinder(h=gear_thickness*2,r=5*mm, center=true);
        cube([gear_thickness+10*mm, gear_thickness+10*mm, 3*mm], center=true);
    }
}
        
        
//===========Final Gear Modules=======================
module gear_1(){//gear for 28BYJ-48-08 stepper axis
    difference(){
        difference(){
            gear_full();
            gear_holes();
        }
        axis_1();
    }
}

//Final Modeling --> TODO: Add other axis models
//printed in 2 copies
rotate(90, axis) gear_1();
translate( [0, gear_radius*2+10, 0] ) rotate(90, axis) gear_1();
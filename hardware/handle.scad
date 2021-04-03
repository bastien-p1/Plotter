mm=1;//initial scale

pt=8*mm;//part thickness
pw=45*mm;//part width
pl=120*mm;//part length
ht=20*mm;//handle thickness
hs=1/4;//hole size (proportion)
ss=5;//screw size
nt=3;//nut thickness
sd=35;//screw distance (in degrees)

hr=pw*hs;//hole radius
ns=ss*1.5;//nut size



module base(){
    union(){
        cylinder(h=pt,r=pw/2);
        translate([-pw/2,0,0]) cube([pw,pl,pt]);
        translate([0,pl,0]) cylinder(h=ht,r=pw/2);
    }
}

module screw(){
    translate([0,0,ht/2]) union(){
        rotate([-90,0,0]) cylinder(h=pw,r=ss/2);
        offset = hr+(pw/2-hr)/2;
        translate([0,offset,0]) cube([ns,nt,ht*2],center=true);
    }
}

module holes(){
    union(){
        cylinder(h=ht*3,r=hr,center=true);
        rotate([0,0,sd]) screw();
        rotate([0,0,-sd]) screw();
    }
}

module pin(){
    union(){
        cylinder(r1=pw/10,r2=pw/15,h=pt/3);
        translate([0,0,pt/4]) cylinder(r1=pw/15,r2=pw/10,h=pt/3);
    }
}

module fixation(){
    translate([pw/5, -pw/4, pt*0.9]) pin();
    translate([-pw/5, -pw/4, pt*0.9]) pin();
    translate([0, pw/4, pt*0.9]) pin();
}

module hook(){
    translate([0,ht/2.8,2/5*ht]) difference(){
        rotate([0,90,0]) cylinder(r=2/5*ht,h=pw/10,center=true);
        rotate([0,90,0]) cylinder(r=1/4*ht,h=pw/5,center=true);
    }
}

union(){
    difference(){
        base();
        translate([0,pl,0]) holes();
    }
    fixation();
    translate([0, (pl+pw/2)-1, 0]) hook();
}
















/*
module corner(thickness,angle,size){
    angle = 90-(angle%90);
    intersection(){
        rotate([0,0,(angle/2)]) cube([size*2,size*2,thickness]);
        rotate([0,0, -(angle/2)]) cube([size*2,size*2,thickness]);
        rotate([0,0,45]) translate([0,0,thickness/2]) cube([size*2,size*2,thickness*2],center=true);
    }
}
*/
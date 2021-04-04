mm=1;//initial scale

pt=8*mm;//part thickness
pr=50*mm;//part radius
rs = 0.8;//ring size (proportion of part thickness)
hs=0.8;//hole size (proportion of part radius)
cs=0.2;//center hole size (proportion of part radius)

hr=pr*hs;
cr=pr*cs;

module ring(){
    rotate([0,0,90]) difference(){
        rotate([0,90,0]) cylinder(r=rs*pt,h=pt,center=true);
        rotate([0,90,0]) cylinder(r=rs*pt/1.5,h=pt*3,center=true);
    }
}

module fixations(){
    for (i = [0:3]){
            rotate((i+1)*90, [0,0,1]) translate([pr-1*mm+rs*pt, 0, 0]) ring();
        }
}

module holes(){
    union(){
        difference(){
            cylinder(r=hr,h=pt*3,center=true);
            rotate([0,0,-45]) translate([0,-pr,0]) cube([pr*2,pr*2,pr*2],center=true);
        }
        cylinder(r=cr,h=pt*3,center=true);
    }
}

module clamp(){
    //TODO
}

module gear(){
    //TODO
}

module base(){
    union(){
        difference(){
            cylinder(r=pr,h=pt);
        }
        translate([0,0,pt*rs]) fixations();
    }
}

difference(){
    base();
    holes();
}

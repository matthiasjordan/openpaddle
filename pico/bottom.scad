include<../common/common.scad>
use<../common/case.scad>
use<base.scad>
use<dl4mat/RasPiPico/picowithstuff.scad>



bottom();
%pico_context();


module bottom() {
    $fn=20;
    
    difference() {
        union() {
            // base plate
            translate([0,0,-skirtheight]) cube([baselength, basewidth, casethickness]);
            
            // end plate
            translate([length-casethickness-0.01, (basewidth-skirtendplatewidth)/2, -skirtheight]) cube([casethickness, skirtendplatewidth, skirtheight+0.01]);
            
            // stopper
            union() {
                screwblock=5.5;
                stopperheight=skirtheight-0.5;
                translate([stopperx, (basewidth-stopperwidth)/2+stopperwidth-screwblock, -skirtheight]) cube([screwblock, screwblock, stopperheight]);
                //translate([stopperx, (basewidth-stopperwidth)/2, -skirtheight]) cube([3, stopperwidth, stopperheight]);
            }
            
            // base nuts
            translate([0,0,-9.0]) for (p = basenutpos) {
                translate([mechstart+p, basewidth/2, casethickness-0.01]) {
                    basenut();
                }
            }
        }
        
        // Edge cut
        translate([0,0,-skirtheight+casethickness/2]) union() {
            edgecutheight=2.2;
            translate([0,0,0]) rotate([0, 0, 45]) cube([2,2,edgecutheight], center=true);
            translate([0,basewidth,0]) rotate([0, 0, 45]) cube([2,2,edgecutheight], center=true);
        }

        // cut out for rail
        union() {
            t = casethickness-skirtrailheight+0.2;
            translate([0,0-0.01,-skirtheight-0.01]) cube([baselength, 1+0.01, t]);
            translate([0,basewidth-1+0.01,-skirtheight-0.01]) cube([baselength, 1+0.01, t]);
            translate([0-0.01,0,-skirtheight-0.01]) cube([1+0.01, basewidth, t]);
        }


        // holes for base nuts
        for (p = basenutpos) {
            translate([mechstart+p, basewidth/2, -10]) cylinder(d=2.6, h=8);
        }
        
        // Hole for LED
        translate([5, 16, -skirtheight-0.2]) cylinder(d=1, h=casethickness+0.5);

        // Hole for BOOTSEL button
        translate([12, 13.5, -skirtheight-0.2]) cylinder(d=1.5, h=casethickness+0.5);
        
        // Hole for stopper screw
        translate([stopperscrewx, stopperscrewy, 10]) rotate([180,0,0]) screwhole(screwdiam=basescrewdiam+0.2, headconeheight=0, headheight=thickness+0.5, shankheight=basescrewheight, headdiam=basescrewheaddiam+0.5);
    }

    %translate([stopperscrewx, stopperscrewy, 5]) rotate([180,0,0]) screwhole(shankheight=10, screwdiam=2.5);

}



module pico_context() {
    %translate([stopperx, 0, picopcbpos-skirtheight+picopcbheight]) rotate([0, 180, 0]) pico_with_stuff();

    module pico() {
        rotate([0,0,180]) mirror([1,1,0]) import("Raspberry Pi Pico.stl");    
    }
}
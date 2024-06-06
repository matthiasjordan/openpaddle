/*
    OpenPaddle

    Copyright (C) 2023  Matthias Jordan

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/    

//////////////////////////////////////////////////////////////////////
//
//
//  The case, that completes the enclosure
//
//
//////////////////////////////////////////////////////////////////////


include<common.scad>



case();



module case() {
    case_back();
    case_front();
    
    translate([0, 0, 0]) case_side();
    translate([0, width, 0]) mirror([0,1,0]) case_side();
    
    case_top();




    module case_back() {
        $fn=20;
        jackd=6.5;
        translate([-casethickness-0.01, 0.01, 0.005]) {
            difference() {
                cube([casethickness, width, caseheight]);
                translate([-0.1, (width-jacksupportwidth)/2, -0.01]) cube([casethickness+0.2, jacksupportwidth, 6]);
                translate([-0.01, width/2, 6]) rotate([0, 90, 0]) cylinder(h=casethickness+0.02, d=jackd);
            }
        }
    }


    module case_front() {
        hole_width=casehole_width;
        hole_height=14;
        translate([length-casethickness, 0.01, 0.005]) {
            difference() {
                cube([casethickness, width, caseheight]);
                translate([-0.1, (width-hole_width)/2, -0.01]) cube([casethickness+0.2, hole_width, hole_height]);
            }
        }
    }


    module case_side() {
        $fn=15;
        blocksize=nutdiam+2;
        insize=nutdiam+0.5;

        difference() {
            side();
            translate([grubscrewpos-insize/2, casethickness-0.01, 0]) cube([insize, casethickness+0.01, caseheight/2+nutdiam/2]);
            translate([grubscrewpos, 3*casethickness-0.01, caseheight/2]) rotate([90, 0, 0]) cylinder(d=grubscrewdiam+0.2, h=3*casethickness);
        }

        // Grub screw and nut
        % translate([grubscrewpos, 0, caseheight/2]) {
            translate([0, grubscrewlength-0.01, 0]) rotate([90, 0, 0]) cylinder(d=grubscrewdiam-0.2, h=grubscrewlength);
            translate([0, 4, 0]) rotate([90, 0, 0]) paddle_nut();
        }
        
        // caselowerthingie
        translate([5, casethickness-0.01, thickness]) cube([10, caselowerthingiewidth, caselowerthingiewidth]);
        
        module side() {
            translate([-0.1, 0, 0]) cube([length+0.2, casethickness, caseheight]);
            translate([grubscrewpos-(blocksize/2), casethickness-0.001, thickness]) cube([blocksize, 3, caseheight-thickness]);
        }
    }


    module case_top() {
        
        barheight=3.3;
        caseborder=border+casethickness;
        
        module bar(hhh) {
            $fn=15;
            translate([0,0,-hhh+0.01]) cylinder(d=8, h=hhh);
        }
        
        module foo() {
            translate([-casethickness, 0, caseheight-casethickness-0.01]) cube([length+casethickness, width, casethickness]);
            
            translate([mechstart, caseborder, caseheight-nutheight]) bar(barheight);
            translate([mechstart, width-caseborder, caseheight-nutheight]) bar(barheight);
            translate([mechstart+middlescrewdistance, width/2, caseheight-nutheight]) bar(2);
        }
        
        module paddle_screw_hole() {
            translate([0,0,-0.5]) rotate([180, 0, 0]) paddlescrewhole();
        }
        
        difference() {
            foo();
            translate([mechstart, caseborder, caseheight-nutheight]) paddle_screw_hole();
            translate([mechstart, width-caseborder, caseheight-nutheight]) paddle_screw_hole();
            translate([mechstart+middlescrewdistance, width/2, caseheight-nutheight]) paddle_nut_hole();
        }
    }

}

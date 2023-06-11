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
//  The base, that holds the TRS jack and the paddles
//
//
//////////////////////////////////////////////////////////////////////


include<common.scad>
use<paddle.scad>
use<lib/trsjack_ebs35.scad>




base();

basewidth=width-2*casethickness;
baselength=length-casethickness;



module base() {

    %paddles();
    
    baseplate_all();
    paddle_fixtures();
    middle_contact_fixture();
    trs_jack_fixture();
    
    
    module baseplate_all() {
        difference() {
            baseplate();
            translate([mechstart, border, thickness-0.01]) paddlescrewhole();
            translate([mechstart, basewidth-border, thickness-0.01]) paddlescrewhole();
            translate([mechstart+middlescrewdistance, basewidth/2, thickness-0.01]) paddlescrewhole();
            
            $fn=20;
            for (p = basenutpos) {
                translate([mechstart+p, basewidth/2, -1]) cylinder(d=2.6, h=8);
            }
        }
    }


    module paddle_fixtures() {
        // Fixture for left paddle
        translate([mechstart, border, thickness-0.01]) ringWithScrew(h=rheight);
        // Fixture for right paddle
        translate([mechstart, basewidth-border, thickness-0.01]) ringWithScrew(h=rheight);
    }

    
    module middle_contact_fixture() {
        // Fixture for middle contact
        ring_heightx=0;
        translate([mechstart+middlescrewdistance, basewidth/2, thickness-0.01]) {
            ringWithScrew(h=ring_heightx);

            // Stoppers for cable shoe
            translate([0, 0, 0]) {
                $fn=10;
                cssh=2.5+ring_heightx;
                translate([-10,-3,0]) cylinder(h=cssh, d=2);
                translate([-10,3,0]) cylinder(h=cssh, d=2);
            }

            %translate([0,0,ring_heightx]) {
                %translate([0,0,cableshoeheight]) rotate([180,0,180]) cable_shoe(thickness=cableshoeheight, d1=7.5, d2=paddlescrewdiam);
                %translate([0,0,0.99]) paddle_nut();
            }
        }
    }

    
    module trs_jack_fixture() {
        cutspace=0.08;
        jacklen=14.3;
        jackwidth=11.6;
        jackheight=6.1;
        jackexcentricity=0.5;
        
        difference() {
            jackfixture();

            translate([14.3, -11.6+6+basewidth/2-jackexcentricity, 6.1+thickness]) {
                %translate([cutspace/2, cutspace/2, cutspace/2]) rotate([180,0,180]) trsjack();
                rotate([180,0,180]) minkowski() {
                    trsjack();
                    cube([cutspace,cutspace,cutspace]);
                }
            }
        }
    }


    module baseplate() {
        cube([baselength, basewidth, thickness]);
        translate([length-casethickness-0.01, (basewidth-casehole_width)/2, 0]) cube([casethickness, casehole_width, thickness]);
        
        pluglength=nutdiam-0.5;
        plugwidth=1.5;
        translate([grubscrewpos-(pluglength/2), 0, 0]) cube([pluglength, 1.5, 4]);
        translate([grubscrewpos-(pluglength/2), basewidth-plugwidth, 0]) cube([pluglength, plugwidth, 4]);

        for (p = basenutpos) {
            translate([mechstart+p, basewidth/2, thickness-0.01]) {
                basenut();
            }
        }
    }


    module jackfixture() {
        translate([0, casethickness, 0]) cube([16, basewidth-casethickness*2, thickness*2]);
        translate([-jacksupportdepth+0.01, (basewidth-jacksupportwidth)/2, 0]) cube([jacksupportdepth, jacksupportwidth, thickness*2]);
    }


    module ringWithScrew(h=ring_height) {
        paddle_ring(h+0.01);
        %translate([0,0,basescrewheight-1]) rotate([180, 0, 0]) xscrew(basescrewdiam, basescrewheight);
    }


    module paddlescrewhole() {
        $fn=20;
        translate([0,0,basescrewheight-1]) rotate([180, 0, 0]) screwhole(screwdiam=basescrewdiam+0.5, headconeheight=0, headheight=thickness+5.5, shankheight=basescrewheight, headdiam=basescrewheaddiam+0.5);
    }
    

    module xscrew(d, h) {
        $fn=20;
        screwhole(screwdiam=d, headconeheight=0, headheight=basescrewheadheight, shankheight=h, headdiam=basescrewheaddiam);
    }


    module trsjack() {
        ebs35();
    }
}




module paddles() {
    translate([mechstart, 0, thickness+rheight]) {
        translate([0, basewidth-border, 0]) paddle();
        translate([0, border, 0]) mirror([0,1,0]) paddle();
    }
}

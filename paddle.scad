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
//  The right paddle.
//
//  This model needs to be mirrored to make the left paddle.
//
//
//////////////////////////////////////////////////////////////////////


include<common.scad>



paddle();



// (0,0,0) is bottom center of hub.
module paddle(length=paddlelength) {
    $fn=20;
    offset=1.4;
    springpinheight=3;
    springpindiam=4;
    topreinforcementheight=3;
    paddleheighttotal=paddleheight+topreinforcementheight;

    hub();
    spring_pin_attached();
    main_bar();


    module main_bar() {
        translate([0,-offset,0]) {
            difference() {
                union() {
                    translate([0.01, -paddlethickness, 0]) cube([length-paddletiplength, paddlethickness, paddleheight]);
                    
                    // Top reinforcement
                    {
                        distfromscrew = 7;
                        distfromtip=9;
                        translate([distfromscrew+0.01, -paddlethickness, 0]) cube([length-paddletiplength-distfromscrew-distfromtip, paddlethickness, paddleheight+topreinforcementheight]);
                    }
                    
                    // Side reinforcement
                    {
                        railsize=(paddleheight-basescrewheaddiam)/2-0.1;
                        raillength=10;
                        translate([paddlelength-paddletiplength-raillength-1, 0, paddleheight-railsize]) cube([raillength, railsize, railsize]);
                        translate([paddlelength-paddletiplength-raillength-1, 0, 0]) cube([raillength, railsize, railsize]);
                    }       
                }
                
                // Hole for screw
                translate([middlescrewdistance, 0.1, paddleheight/2]) rotate([90, 0, 0]) {
                    cylinder(h=paddlethickness+1, d=paddlescrewdiam+0.5);
                    %translate([0,0,4]) rotate([180,0,0]) screwhole(screwdiam=paddlescrewdiam, headconeheight=0,headheight=1,shankheight=4);
                }
                
                // Space for cable shoe
                translate([middlescrewdistance, -2.01, (paddleheight/2)]) rotate([270, 175, 0]) {
                    cable_shoe(thickness=0.99, d1=7.5, d2=paddlescrewdiam);
                    %cable_shoe(thickness=0.99, d1=7.5, d2=paddlescrewdiam);
                    %translate([0,0,-2]) paddle_nut();
                }

                // Space for springpin
                translate([15, 1.0-paddlethickness, paddleheight/2+1]) spring_pin(0.3);
                
            }
            
            // Tip
            translate([length-paddletiplength, -paddlethickness, paddleheight-paddletipheight]) cube([paddletiplength,2.5, paddletipheight]);
        }
    }


    module hub() {
        height=paddleheight;
        paddle_ring(height);
    }


    module spring_pin_attached() {
        translate([15, -paddlethickness-offset, paddleheighttotal]) {
            translate([0, springpinheight, springpindiam/2+0.51]) spring_pin();
            translate([-1/2, 0, 0]) cube([1, 1, 2]);
        }
    }


    module spring_pin(e=0) {
        rotate([90, 0, 0]) cylinder(d=springpindiam+e, h=springpinheight);
    }
    
}




module paddle_ring(height) {
    $fn=20;
    inner_diam=screwholediam;
    outer_diam=5;
    difference() {
        cylinder(height, d=outer_diam);
        translate([0,0,-0.01]) cylinder(height+0.02, d=inner_diam);
    }
}



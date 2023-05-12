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
// A slide-on housing.
//
//
//////////////////////////////////////////////////////////////////////

include<../common.scad>
use<../case.scad>
use<../base.scad>

housing();



module housing() {
    paddleoutreach=10;
    jackdepth=2;
    pad=0.2;

    housinglength=jackdepth+jacksupportdepth+length+paddleoutreach;
    housingwidth=width + 2*pad;
    housingthickness=2;
    ht=housingthickness;

    stripwidth=width/3;
    gapwidth=1;
    
    main_block();
    ball_stopper();

    %translate([jacksupportdepth+jackdepth, pad, pad]) {
        case();
        translate([0, casethickness, 0]) base();
    }    
    
    
    module main_block() {
        difference() {
            translate([0, -ht, -ht]) cube([housinglength, width+(pad+housingthickness)*2, caseheight+(pad+housingthickness)*2]);
            translate([-0.05, 0, 0]) cube([housinglength+0.1, width+pad*2, caseheight+pad*2]);

            // Spring thingy
            spring_thingy_length=35;
            translate([(housinglength-spring_thingy_length)/2, (width-stripwidth)/2, -3]) {
                translate([0, 0, 0]) cube([spring_thingy_length, gapwidth, 4]);
                translate([0, stripwidth-gapwidth, 0]) cube([spring_thingy_length, gapwidth, 4]);
            }
        }
    }


    module ball_stopper() {
        $fn=15;
        ballpos=jackdepth+jacksupportdepth+mechstart+basenutpos[1];
        translate([ballpos, housingwidth/2, -0.7]) {
            intersection() {
                sphere(d=3);
                translate([-1.5,-1.5,0]) cube([3,3,1.5]);
            }
            
        }
    }


}

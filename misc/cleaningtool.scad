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
// This is an attempt at a tool for cleaning the holes for the screws.
// It degrades quickly, though, and doesn't really help that much.
//
//
//////////////////////////////////////////////////////////////////////


include<common.scad>



$fn=15;
lowerheight=9;
upperheight=5;
cubesize=(basescrewheaddiam-basescrewdiam)/2;

union() {
    // lower stick
    intersection() {
        stick(basescrewdiam, lowerheight+0.01, 0.4);
        cylinder(h=lowerheight, r1=0, r2=4);
    }

    // upper stick
    translate([0,0,lowerheight]) stick(basescrewheaddiam, upperheight, 0.6);
    
    // scratch cubes
    {
    corr=0.20;
        translate([0, 0, lowerheight-(cubesize/1.4)/2-0.3]) {
            translate([basescrewheaddiam/2-cubesize-corr, 0, 0]) rotate([45,0,0]) cube([cubesize, cubesize, cubesize]);
            translate([-cubesize-(basescrewheaddiam/2-cubesize)+corr, 0, 0]) rotate([45,0,0]) cube([cubesize, cubesize, cubesize]);
        }
    }
    
    // handle
    translate([0, 0, lowerheight+upperheight]) cylinder(d=5, h=15);
}
    


module stick(d, h, cut) {
    difference() {
        cylinder(h=h, d1=d*0.9, d2=d);
        translate([cut, cut, -0.01]) cube([5, 5, h+0.02]);
        mirror([1,1,0])translate([cut, cut, -0.01]) cube([5, 5, h+0.02]);
    }
    
}

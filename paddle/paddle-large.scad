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
//  The plain paddle - right side only.
//
//  This model needs to be mirrored to make the left paddle.
//
//
//////////////////////////////////////////////////////////////////////



include<common.scad>
include<paddle-common.scad>


paddle();

module tip() {
    length=16;
    height=14;
    width=3;
    spr=50;

    difference() {
        main();
        $fn=spr;
        translate([8,spr+2.2,6]) sphere(r=spr);
    }
    reinforcement();

    module main() {
        translate([0,width,0])
        rotate([90, 0 , 0]) 
        linear_extrude(height=width)  
        polygon(points=[
            [0,0], // LL
            [length-2,-1],[length-1,-.5],[length,0], // LR
            [length-1,height-1], [length-1.5,height-.5], [length-2,height],// UR
            [0,height-1] // UR
            ]);
    }

    module reinforcement() {
        railsize=1.5;
        translate([-2,width-railsize,3]) cube([3,railsize,7]);

        translate([-2,width-railsize+0.5,3]) cube([3,railsize,railsize]);
        translate([-2,width-railsize+0.5,8.5]) cube([3,railsize,railsize]);
    }
}


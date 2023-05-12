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
// A cable shoe.
//
//
//////////////////////////////////////////////////////////////////////

cable_shoe();

module cable_shoe(d1=7, d2=3, l=12.5, shaftd=3.5, thickness=0.5) {
    $fn=20;
    shaftlen=6;

    difference() {
        main();
        translate([0,0,-0.5]) cylinder(d=d2, h=thickness+1);
    }
    
    module main() {
        cylinder(r=d1/2, h=thickness);
        linear_extrude(height=thickness) polygon(points=[[0,-d1/2], [0,d1/2], [l-3,shaftd/2], [l-3,-shaftd/2]]);
        translate([l-shaftlen, 0, thickness-shaftd/2]) rotate([0,90,0]) cylinder(h=6, d=shaftd);
    }
}

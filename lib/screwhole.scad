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
// A helper for cut-outs of screws.
//
//
//////////////////////////////////////////////////////////////////////


screwhole();

module screwhole(screwdiam=2.2, headdiam=4, headconeheight=1, headheight=4, shankheight=6) {

    // Shank
    translate([0, 0, -0.01]) linear_extrude(height=shankheight+0.02) circle(screwdiam/2);

    // Head
    translate([0, 0, shankheight+headconeheight]) rotate([0, 180, 0]) cylinder(h=headconeheight+0.01, r1=headdiam/2, r2=screwdiam/2, center=false);

    // Hole above head
    translate([0, 0, shankheight+headconeheight+headheight+0.01]) rotate([0, 180, 0]) cylinder(h=headheight+0.02, r=headdiam/2, center=false);

}


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
// A TRS jack type EBS35.
//
//
//////////////////////////////////////////////////////////////////////

ebs35();

module ebs35() {
    
    echo(str("\n\n",
    "=============================\n",
    "Wiring diagram\n",
    "Jack shown with connector pins facing towards user\n",
    "\n",
    "    +-+    \n",
    "+---------+\n",
    "|    C    |\n",
    "|        L|\n",
    "|  x      |\n",
    "|R       x|\n",
    "+---------+\n",
    "\n\n",
    "C: center pin\n",
    "R: right paddle\n",
    "L: left paddle\n",
    "x: not connected\n"
    ));
    
    
    $fn=20;
    jackcyllen=3.6;
    len=14.3;
    cube([len, 11.6, 6.1]);
    
    pinthickness=0.5;
    pinwidth=1.2;
    pinheight=3.2;
    translate([len, (11.6-5.5), 6.1/2]) rotate([0, 90, 0]) cylinder(d=6.1, h=jackcyllen);
    
    translate([0, -pinthickness/2, 0]) {
        translate([17.9-13.4, 11.6-5.5-5.2, -3.2]) rotate([0, 0, 90]) color("red") cube([pinthickness, pinwidth, pinheight+0.01]);

        translate([17.9-9.3, 11.6-5.5+4.6, -3.2]) rotate([0, 0, 90]) color("red") cube([pinthickness, pinwidth, pinheight+0.01]);


    }
    
    translate([17.9-5.4, 11.6-5.5-pinwidth/2, -3.2]) rotate([0, 0, 0]) color("red") cube([pinthickness, pinwidth, pinheight+0.01]);

}

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
//  Common values and code
//
//
//////////////////////////////////////////////////////////////////////


use<BOLTS/BOLTS.scad>
use<lib/cableshoe.scad>
use<lib/screwhole.scad>


width=25;
length=62;
thickness=3;
casethickness=2;
jacksupportdepth=2;
jacksupportwidth=6.5;



basescrewdiam = 2.5;
basescrewheight=16;
basescrewheaddiam=4.2;
basescrewheadheight=1.5;
basenutpos = [0, 10];
basewidth=width-2*casethickness;
baselength=length-casethickness;

caseheight=thickness+basescrewheight;
caselowerthingiewidth=1.8;
casehole_width=17;


paddlelength=52;
paddleheight=7;
paddlethickness=2.0;
paddlescrewdiam=2.5;
paddletiplength=12;
paddletipheight=10;


middlescrewdistance=35;

nutdiam=5;
nutheight=2;
cableshoeheight=1;

grubscrewdiam=2.5;
grubscrewlength=6;
grubscrewpos=middlescrewdistance+10;


mechstart=20;
border=3;


picopcbheight=1;
picopcbwidth=21;
picopcblength=51;
picopcbpos=6.2;
skirtheight=9;
skirtendplatewidth=picopcbwidth+1.0;
skirtrailheight=picopcbheight;
skirtrailgap=0.5;
stopperwidth=picopcbwidth-4;
stopperx=picopcblength;
stopperscrewx=stopperx+3;
stopperscrewy=16.5;


ring_height=0.5;
rheight=ring_height+cableshoeheight+nutheight;


screwholediam = basescrewdiam+0.1;


lowerheight=5;

fullassemblyheight=caseheight+skirtheight;


module paddle_nut() {
    nut1(d1=paddlescrewdiam, s=5, m_max=nutheight);
}

module paddle_nut_hole() {
    nut1(d1=0, s=5, m_max=nutheight+2);
    screwholeheight=4;
    $fn=15;
    translate([0,0,-screwholeheight+0.01]) cylinder(d=basescrewdiam, h=screwholeheight);
}

module basenut() {
    %paddle_nut();
    r=4.1;
    difference() {
        cylinder(r=r, h=2.3);
        paddle_nut_hole();
    }
   translate([0,0,2.29]) cylinder(r=r, h=0.5);    
}

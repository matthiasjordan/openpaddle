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
//  The full monty for visual inspection
//
//
//////////////////////////////////////////////////////////////////////


include<common.scad>
use<paddle.scad>
use<base.scad>
use<case.scad>
use<bottom.scad>

base();
paddles();
%translate([0, -casethickness, 0]) case();
translate([20,0,0]) bottom();
%pico_context();
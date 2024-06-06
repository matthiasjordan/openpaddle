microusb_cutout = [9, 3.5];

microusb_cutout();

module microusb_cutout(depth=3) {
    width=microusb_cutout.x;
    height=microusb_cutout.y;
    
    corner=1;
    
    half_long = width/2-corner;
    half_height = height/2-corner;
    
    linear_extrude(depth) polygon(points=[
        // Upper left corner
        [-half_long-corner, half_height+corner],
        // Upper right corner
        [half_long+corner, half_height+corner],
    
        [half_long+corner, half_height],
        [half_long+corner, -half_height],

        [half_long, -half_height-corner],
        [-half_long, -half_height-corner],

        [-half_long-corner, -half_height],
        [-half_long-corner, half_height],
    ]);
}

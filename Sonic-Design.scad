/*Hussain Mumtaz
husmum@gatech.edu
*/

INVERTER_FACTOR = -1;

BLACK =  "Black";
BLUE = [.31, .45, .69];
WHITE = "White";
LIME_GREEN = "LimeGreen";
SKIN = [.90,.596,.41];

EYEBALL_OFFSET_X = 14;
EYEBALL_OFFSET_Y = 8;
EYEBALL_OFFSET_Z = 4;
EYEBALL_RADIUS = 5;
EYEBALL_SMALLEST_RADIUS = 3;

function invert (number) = number * INVERTER_FACTOR;

//Lets make Sonic's Head

//F6 renders without color

module base () {
	height = 2;
	radius = 32;
	offset = [-6,0,-20];

	color(BLACK)
		translate(offset)
			cylinder(h=height,r=radius);
}

module head () {
	outter_radius = 20;
	inner_radius = outter_radius - 2;

	color(BLUE)
		sphere(r=outter_radius);
	
		sphere(r=inner_radius);
}

module eyeball_shape (radius, offset_x) {
	hull(){
		translate([offset_x, EYEBALL_OFFSET_Y ,EYEBALL_OFFSET_Z])
			sphere(r=radius);
		translate([offset_x, invert(EYEBALL_OFFSET_Y), EYEBALL_OFFSET_Z])
			sphere(r=radius);
	}
}

module eyeball_space () {
	offset_x = EYEBALL_OFFSET_X + 1;

	eyeball_shape (EYEBALL_RADIUS, offset_x);
}

module head_base () {
	difference(){
		head();
		eyeball_space();
	}
}

module eyeball () {
	color(WHITE) {
		difference() {
			eyeball_shape (EYEBALL_RADIUS, EYEBALL_OFFSET_X);
		}
		
		eyeball_shape (EYEBALL_SMALLEST_RADIUS, EYEBALL_OFFSET_X);
	}
}

module iris (y) {
	color(LIME_GREEN) {
		translate([18.3,y,EYEBALL_OFFSET_Z]) {
			scale([2.0,2.0,3.0]) 
				sphere(r=1.0); 
		}
	}
}

module pupil (y) {
	color(BLACK) {
		translate([19.6,y,EYEBALL_OFFSET_Z - 1]){
			scale([1,1,2])
				sphere(r=1);
		}
	}
}

module light (y) {
	color(WHITE) {
		translate([20.1,y-.2,EYEBALL_OFFSET_Z - 2]) {
				sphere(r=.4);
		}
	}
}

module eye(y) {
	iris(y);
	pupil(y);
	light(y);
}

module eyes () {
	y = EYEBALL_OFFSET_Y - 1;

	eyeball();
	eye(y);
	eye(invert(y));
}



//Sonic's spiky hair
module hair(d,x,y,z,r){ 
	color([.31, .45, .69])
		rotate([0,d,0])
			translate([x,y,z])
				cylinder(h=5,r=r);
}

module positioned_hair(x,y,z){
	delta = 90;
	radius = 8;
	height = 5;
	number_of_parts = 25;

	for (i = [0:number_of_parts]){
		color(BLUE)
			rotate([0, delta - i, 0])
				translate([x - i / number_of_parts, y, z - i])
					cylinder(h=height,r=radius - i / 3.125);
	}
}

module hair () {
	z = -8;

	positioned_hair(-12,0,z);
	positioned_hair(-5,8,z);
	positioned_hair(-5,-8,z);
	positioned_hair(5,8,z);
	positioned_hair(5,-8,z);
	positioned_hair(0,0,z);
}

module nostril (z) {
	radius = 2;
	
	translate([1,0,z])
		sphere(r=radius);
}

module nose () {
	offset_z = 3;

	translate([20,0,0])
	difference(){
		color("Black")
		hull(){
			sphere(r=2);
	
			translate([2,0,0])
				sphere(r=2.4);
		}
	
		nostril(offset_z);
	
		nostril(invert(offset_z));
	} 
}

module mouth_area () {
	color(SKIN)
	translate([7,0,0])
		difference(){
			sphere(r=15);
	
			translate([-15,-15,-15])
				cube([15,30,30]);
	
			rotate([0,90,0])
				translate([-15,-15,-15])
					cube([15,30,30]);
	
			sphere(r=13.5);
	
			translate([8,-7.5,6])
				sphere(r=9);
	
			translate([8,7.5,6])
				sphere(r=9);
	
			translate([15,0,2])
				sphere(r=4);
	}
}

module smirk () {
	color("Black")
	translate([-10,3,-7]){
		difference(){
			rotate([15,0,0])
			translate([30,0,0])
			scale([1,4,1])
				sphere(r=1);
			
			rotate([15,0,0])
			translate([30,0,1])
			scale([1,4,1])
				sphere(r=1);
		}
		
		difference(){
			rotate([-15,0,0])
			translate([30,3,2])
			scale([1,1,4])
				sphere(r=1);
			
			rotate([-15,0,0])
			translate([30,3,0])
			scale([1,1,4])
				sphere(r=1);
		}
		
		difference(){
			rotate([15,0,0])
			translate([30,3.5,0])
			scale([1,1,4])
				sphere(r=1);
			
			rotate([15,0,0])
			translate([30,3.5,2])
			scale([1,1,4])
				sphere(r=1);
		}
	}
}

module ear() {
	color([.31, .45, .69])
		difference() {
			cylinder(h=10, r1=5, r2=0);
			
			cylinder(h=6, r1=4, r2=0);
			
			translate([0,-5,0])
			cube([10,10,10]);
		}

	//Inner lobes. The difference shading is eh, 
	//but it is needed to indicate the inner lobes
	color([.90,.596,.41])
		difference() {
			cylinder(h=6, r1=4, r2=0);
			
			translate([0,-4,0])
			cube([8,8,8]);
		}
}


module ears() {
	translate([5,10,16])
		rotate([-25,0,0])
			ear();
	
	translate([5,-10,16])
		rotate([25,0,0])
			ear();
}

module sonic () {
	head_base();
	eyes();
	hair();
	nose();
	mouth_area();
	smirk();
	ears();
}

module main () {
	base();
	sonic();
}

main();

	



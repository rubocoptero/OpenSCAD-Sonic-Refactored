/*Hussain Mumtaz
husmum@gatech.edu
*/

INVERTER_FACTOR = -1;

BLACK =  "Black";
BLUE = [.31, .45, .69];
WHITE = "White";

EYEBALL_OFFSET_X = 14;
EYEBALL_OFFSET_Y = 8;
EYEBALL_OFFSET_Z = 4;
EYEBALL_RADIUS = 5;
EYEBALL_SMALLEST_RADIUS = 3;


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

module eyeball_space () {
	offset_x = EYEBALL_OFFSET_X + 1;

	hull(){
		translate([offset_x, EYEBALL_OFFSET_Y, EYEBALL_OFFSET_Z])
				sphere(r=EYEBALL_RADIUS);
		
		translate([offset_x, EYEBALL_OFFSET_Y * INVERTER_FACTOR, EYEBALL_OFFSET_Z])
				sphere(r=EYEBALL_RADIUS);
	}
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
			hull(){
				translate([EYEBALL_OFFSET_X, EYEBALL_OFFSET_Y ,EYEBALL_OFFSET_Z])
					sphere(r=EYEBALL_RADIUS);
				translate([EYEBALL_OFFSET_X, EYEBALL_OFFSET_Y * INVERTER_FACTOR,EYEBALL_OFFSET_Z])
					sphere(r=EYEBALL_RADIUS);
			}
		}
		
		hull(){
			translate([EYEBALL_OFFSET_X, EYEBALL_OFFSET_Y ,EYEBALL_OFFSET_Z])
					sphere(r=EYEBALL_SMALLEST_RADIUS);
				translate([EYEBALL_OFFSET_X,EYEBALL_OFFSET_Y * INVERTER_FACTOR,EYEBALL_OFFSET_Z])
					sphere(r=EYEBALL_SMALLEST_RADIUS);
		}
	}
}

module eye(y) {
	//Iris
	color("LimeGreen") {
		translate([18.3,y,4]) {
			scale([2.0,2.0,3.0]) 
				sphere(r=1.0); 
		}
	}
	
	//Pupil
	color("Black") {
		translate([19.6,y,3]){
			scale([1,1,2])
				sphere(r=1);
		}
	}

	//Light
	color("White") {
		translate([20.1,y-.2,2]) {
				sphere(r=.4);
		}
	}
}

module eyes () {
	eyeball();
	eye(7);
	eye(-7);
}

base();
head_base();
eyes();

//Sonic's spiky hair
module hair(d,x,y,z,r){ 
	color([.31, .45, .69])
		rotate([0,d,0])
			translate([x,y,z])
				cylinder(h=5,r=r);
}

//Unfortunately SCAD doesn't allow calling 
//modules within modules, excuse how messy this 
//looks

for (i = [0:25]){
	hair(90-i,-12-i/25,0,-8-i,8-i/3.125);
}

for (i = [0:25]){
	hair(90-i,-5-i/25,8,-8-i,8-i/3.125);
}

for (i = [0:25]){
	hair(90-i,-5-i/25,-8,-8-i,8-i/3.125);
}

for (i = [0:25]){
	hair(90-i,5-i/25,8,-8-i,8-i/3.125);
}

for (i = [0:25]){
	hair(90-i,5-i/25,-8,-8-i,8-i/3.125);
}

for (i = [0:25]){
	hair(90-i,0-i/25,0,-8-i,8-i/3.125);
}

//Nose

translate([20,0,0])
difference(){
	color("Black")
	hull(){
		sphere(r=2);

	translate([2,0,0])
		sphere(r=2.4);}

	translate([1,0,3])
		sphere(r=2);

	translate([1,0,-3])
		sphere(r=2);} 

//Mouth Area

color([.90,.596,.41])
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
			sphere(r=4);}

//Smirk

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
}}

//Ears

module ear() {
color([.31, .45, .69])
difference(){
cylinder(h=10, r1=5, r2=0);

cylinder(h=6, r1=4, r2=0);

translate([0,-5,0])
cube([10,10,10]);
}

//Inner lobes. The difference shading is eh, 
//but it is needed to indicate the inner lobes

color([.90,.596,.41])
difference(){
cylinder(h=6, r1=4, r2=0);

translate([0,-4,0])
cube([8,8,8]);}
}
translate([5,10,16])
rotate([-25,0,0])
ear();

translate([5,-10,16])
rotate([25,0,0])
ear();

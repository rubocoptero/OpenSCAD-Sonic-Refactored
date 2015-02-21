/*Hussain Mumtaz
husmum@gatech.edu
*/

BLACK =  "Black";
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

base();

//Face and space for eyes
difference(){
	color([.31, .45, .69])
		sphere(r=20);
	
		sphere(r=18);
	hull(){
		translate([15,8,4])
				sphere(r=5);
		
		translate([15,-8,4])
				sphere(r=5);}}

//Eyes

//Base
color("White"){
difference(){
	hull(){
		translate([14,8,4])
			sphere(r=5);
		translate([14,-8,4])
			sphere(r=5);}}

	hull(){
		translate([14,8,4])
			sphere(r=3);
		translate([14,-8,4])
			sphere(r=3);}}

module eye(y)
{
	//Iris
	color("LimeGreen"){
		translate([18.3,y,4]) {
			scale([2.0,2.0,3.0]) 
				sphere(r=1.0); }}
	
	//Pupil
	color("Black"){
		translate([19.6,y,3]){
			scale([1,1,2])
				sphere(r=1);}}

	//Light
	color("White"){
		translate([20.1,y-.2,2]){
				sphere(r=.4);}}}

eye(7);
eye(-7);

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

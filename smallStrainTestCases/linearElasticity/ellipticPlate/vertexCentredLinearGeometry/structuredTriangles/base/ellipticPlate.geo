// Average mesh spacing
dx = 0.1;

// Lower width
Ll = 1.25;

// Higher width
Lh = 1.75;

// Major radius
rmajor = 2;

// Minor radius
rminor = 1;

// Out of plane depth
t = 0.6;

//Cell multiplier
cn = 1;

//Coefficients of internal ellipse
a = 2;
b = 1;

//Coefficients of external ellipse
c = 3.25;
d = 2.75;

//Focal point
F = (a^2 - b^2)^(1/2);

// Points
Point(1) = {rmajor, 0, 0, dx};
Point(2) = {rmajor+Ll, 0, 0, dx};
Point(3) = {0, rminor, 0, dx};
Point(4) = {0, rminor+Lh, 0, dx};
Point(5) = {0, 0, 0, dx};
Point(6) = {F, 0, 0, dx};

// Lines
Line(1) = {1, 2};
Line(2) = {4, 3};
Ellipse(3) = {1, 5, 6, 3};
Ellipse(4) = {2, 5, 6, 4};

// Surface
Curve Loop(1) = {3, -2, -4, -1};
Plane Surface(1) = {1};

/*//Force mapped meshing (triangles)*/
Transfinite Curve {1, 2} = (4*cn)+1 Using Progression 1;
Transfinite Curve {4, 3} = (10*cn)+1 Using Progression 1;
Transfinite Surface {1};

//Recombine surface to get quadrilaterals
//Recombine Surface {1};

// Create volume by extrusion
Extrude {0, 0, t} {
   Surface{1}; 
   Layers{2*cn}; 
   //Recombine;
}

Physical Surface("inside") = {13};
Physical Surface("symmy") = {25};
Physical Surface("outside") = {21};
Physical Surface("symmx") = {17};
Physical Surface("top") = {26};
Physical Surface("bottom") = {1};
Physical Volume("internal") = {1};


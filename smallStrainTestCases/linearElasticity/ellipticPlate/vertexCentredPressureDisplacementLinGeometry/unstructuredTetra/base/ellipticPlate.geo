// Average mesh spacing
dx = 0.8;

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
cn = 2;

//Coefficients of internal ellipse
a = 2;
b = 1;

//Coefficients of external ellipse
c = 3.25;
d = 2.75;

//Focal point
F = (a^2 - b^2)^(1/2);

// Points
Point(1) = {rmajor, 0, 0, dx/5};
Point(2) = {rmajor+Ll, 0, 0, dx};
Point(3) = {0, rminor, 0, dx};
Point(4) = {0, rminor+Lh, 0, dx};
Point(5) = {0, 0, 0, dx};
Point(6) = {F, 0, 0, dx};
Point(7) = {2.1, 0, 0, dx/5};
Point(8) = {0, 2.1, 0, dx};
Point(10) = {(4/5)^(1/2), (4/5)^(1/2), 0, dx};
Point(11) = {(2.205)^(1/2), (2.205)^(1/2), 0, dx};
Point(12) = {(1/((1/10.5625)+(1/7.5625)))^(1/2), (1/((1/10.5625)+(1/7.5625)))^(1/2), 0, dx};

// Lines
Line(1) = {10, 11};
Line(2) = {11, 12};
Ellipse(3) = {10, 5, 6, 3};
Ellipse(4) = {10, 5, 6, 1};
Line(5) = {1, 7};
Line(6) = {7, 2};
Line(7) = {3, 8};
Line(8) = {8, 4};
Circle(9) = {7, 5, 11};
Ellipse(10) = {12, 5, 6, 4};
Ellipse(11) = {2, 5, 6, 12};
Circle(12) = {11, 5, 8};

// Surface
Curve Loop(1) = {3, 7, -12, -1};
Plane Surface(1) = {1};
Curve Loop(2) = {9, -1, 4, 5};
Plane Surface(2) = {2};
Curve Loop(3) = {6, 11, -2, -9};
Plane Surface(3) = {3};
Curve Loop(4) = {10, -8, -12, 2};
Plane Surface(4) = {4};

//Force mapped meshing (triangles)
//Transfinite Curve {5, 1, 7} = (2*cn)+1 Using Progression 1.02;
//Transfinite Curve {3, 4, 9, 12, 11, 10} = (5*cn)+1 Using Progression 1;
//Transfinite Curve {2, 8} = (5*cn)+1 Using Progression 0.98;
//Transfinite Curve {6} = (5*cn)+1 Using Progression 1.02;
//Transfinite Surface {1, 2, 3, 4};

//Recombine surface to get quadrilaterals
//Recombine Surface {1, 2, 3, 4};

// Create volume by extrusion

Extrude {0, 0, t} {
   Surface{1}; Surface{2}; Surface{3}; Surface{4}; 
   //Layers{2*cn}; 
   //Recombine;
}

Physical Surface("inside") = {51, 21};
Physical Surface("symmy") = {55, 65};
Physical Surface("outside") = {69, 87};
Physical Surface("symmx") = {25, 91};
Physical Surface("top") = {56, 78, 34, 100};
Physical Surface("bottom") = {1, 2, 3, 4};
Physical Volume("internal") = {1, 2, 3, 4};


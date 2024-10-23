// Mesh spacing
dx = 0.01;

// Beam length
L = 2;

// Beam thickness
t = 0.1;

// Depth (out of plane)
d = 0.1;

//Number for multiple meshes
cn = 1;

// Points
Point(1) = {0, -t/2, 0, dx};
Point(2) = {L, -t/2, 0, dx};
Point(3) = {L, t/2, 0, dx};
Point(4) = {0, t/2, 0, dx};

// Lines
Line(1) = {4, 3};
Line(2) = {3, 2};
Line(3) = {2, 1};
Line(4) = {1, 4};

// Surface
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Force mapped meshing (triangles)
Transfinite Curve {1, 3} = (40*cn) + 1 Using Progression 1;
Transfinite Curve {4, 2} = (2*cn) + 1 Using Progression 1;
Transfinite Surface {1};

// Optional: combine triangles into quadrilaterals
Recombine Surface {1};

// Create volume by extrusion
Physical Volume("internal") = {1};
Extrude {0, 0, d} {
 Surface{1};
 Layers{1};
 Recombine;
}

// Boundary patches
Physical Surface("fixed") = {25};
Physical Surface("back") = {13};
Physical Surface("top") = {26};
Physical Surface("load") = {17};
Physical Surface("bottom") = {1};
Physical Surface("front") = {21}; 


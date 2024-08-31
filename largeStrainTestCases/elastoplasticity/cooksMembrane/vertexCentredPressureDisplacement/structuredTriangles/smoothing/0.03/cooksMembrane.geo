// Mesh spacing
dx = 8;

//Number for multiple meshes
cn = (2^(5-1));

// Points
Point(1) = {0, 0, 0, dx};
Point(2) = {48, 44, 0, dx};
Point(3) = {48, 60, 0, dx};
Point(4) = {0, 44, 0, dx};

// Lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

// Surface
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Force mapped meshing (triangles)
Transfinite Curve {1, 3} = (6*cn) + 1 Using Progression 1;
Transfinite Curve {4, 2} = (3*cn) + 1 Using Progression 1;
Transfinite Surface {1};

// Create volume by extrusion
Physical Volume("internal") = {1};
Extrude {0, 0, 2.5} {
 Surface{1};
 Layers{1};
 Recombine;
}

// Boundary patches
Physical Surface("frontAndBack") = {1, 26};
Physical Surface("topAndBottom") = {21, 13};
Physical Surface("right") = {17};
Physical Surface("left") = {25};

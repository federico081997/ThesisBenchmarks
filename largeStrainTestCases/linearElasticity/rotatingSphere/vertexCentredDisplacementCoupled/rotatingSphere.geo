// Sphere radius
R = 1;

SetFactory("OpenCASCADE");
Sphere(1) = {0, 0, 0, R};

lc = 0.09; // Characteristic length for mesh refinement
Field[1] = MathEval;
Field[1].F = Sprintf("(%g + %g * sqrt((x)^2 + (y)^2 + (z)^2))", lc, lc);
Background Field = 1;

//Physical groups
Physical Surface("sides") = {1};
Physical Volume("internal") = {1};

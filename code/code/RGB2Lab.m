function [L,a,b] = RGB2Lab(RGB)

 var_R = RGB(1) / 255; %RGB deðerlerini normalize ediyor.
 var_G = RGB(2) / 255;
 var_B = RGB(3) / 255;

if var_R > 0.04045
     var_R = ((var_R + 0.055) / 1.055) ^ (2.4);
else
    var_R = var_R / 12.92;
end
if var_G> 0.04045
    var_G = ((var_G + 0.055) / 1.055) ^ (2.4);
else
    var_G = var_G / 12.92;
end
if var_B> 0.04045
    
    var_B = ((var_B + 0.055) / 1.055) ^ (2.4);
else
    var_B = var_B / 12.92;
end
var_R = var_R * 100;
var_G = var_G * 100;
var_B = var_B * 100;

X = var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805;
Y = var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722;
Z = var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505;

var_X = double (X) / 95.047 ;         % d65 sabitleri
var_Y = double (Y) / 100.000;
var_Z = double (Z) / 108.883; 

if  var_X > 0.008856
    var_X = var_X.^ (1./3.);
else
    var_X = ( 7.787 * var_X ) + ( 16. / 116. );   % burada 7.787 deðeri k sabitidir.
end
if  var_Y > 0.008856
    var_Y = var_Y.^ (1./3.);
else
     var_Y = ( 7.787 * var_Y ) + ( 16. / 116. );
end
if var_Z > 0.008856
     var_Z = var_Z.^ (1./3.);
else
    var_Z = ( 7.787 * var_Z ) + ( 16. / 116. );
end

L  = (116 * var_Y) - 16;
a  = 500 * (var_X - var_Y);
b  = 200 * (var_Y - var_Z);

if nargout < 2
  L = cat(3,L,a,b);
end
end
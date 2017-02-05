% Calculation of satellite look angle, azimuth, and range for a fixed ground earth station
%
% Author: Mohamad Hilmi bin Mohamad Bakhari (GP04543)
% Date: 5 February 2017

clear all;

Le = 101.785947; % longitude of the earth station
le = 2.9289612; % latitude of the earth station

Ls1 = Le - 22.25; % lower bound of the SSP longitude
Ls2 = Le +22.25; % upper bound of the SSP longitude

iteration = 10; % number of iteration to calculate look angle and azimuth from lower to upper bound
Lq = (Ls2 - Ls1) / iteration; % number of jump for each loop

ls = 0; % latitude of the satellite = 0 because it is a geosynchronous satellite

% ASSUMPTIONS %
Re = 6.37*10^6; % earth radius in [meter]
Hs = 35800*10^3; %satellite height in [meter]
Rs = Re + Hs; % satellite radius in [meter]

fprintf("Proposed Ground Station Calculation\n");
fprintf("Location: UKM (%f, %f)\n\n", Le, le);
fprintf("Longitude\tElevation\tAzimuth\t\tRange (m)\n");
fprintf("---------\t---------\t-------\t\t---------\n");

for Li = Ls1:Lq:Ls2
  
    gamma = acosd(sind(Li)*sind(Le) + cosd(Li)*cosd(Le)*cosd(ls-le));
    range = sqrt(Re^2 + Rs^2 - 2*Re*Rs*cosd(gamma));
    El = acosd( (Rs * sind(gamma)) / range);
    alpha = asind( sind(abs(le - ls)) * cosd(Li) / sind(gamma));
 
    %TODO: to cater for northern hemisphere %
    Az = 0; % azimuth 
    if(Le-Li > 0) % i.e. satellite is to the south west
      Az = 180 + alpha;
    else % i.e. satellite to the south east
      Az = 180 - alpha;
    end

    fprintf("%f\t%f\t%f\t%f\n", Li, El, Az, range);
end

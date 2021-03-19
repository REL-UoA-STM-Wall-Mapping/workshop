%
%   Simple PCD Display
%   Author: Keitaro Naruse
%   Date: 2020-08-31
%

% Read pcd file and display it 
pt2 = pcread('Captured_Frame2.pcd');
figure(2);
pcshow(pt2);
title('Raw PCD');

locationSize = size(pt2.Location)
uMax = locationSize(1);
vMax = locationSize(2);
dMax = locationSize(3);


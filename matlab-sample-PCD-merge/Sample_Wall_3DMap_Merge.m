%
%   Simple Wall 3DMap Merge
%   Author: Keitaro Naruse
%   Date: 2020-03-09
%

% Read pcd file of the top camera position of z=1.3[m] in the world frame
ptCloudTop = pcread('pcl1583215775.pcd');
figure(1);
pcshow(ptCloudTop);
title('Raw PCD of top camera position');

% Set an affine matrix for this came position
% It is a homogeneous transformation matrix in this case
% (Y, Z) axis in the camera frame is (Z, Y)axis in the world one
% T1 = [1, 0, 0, 0;... 
%       0, 1, 0, 0;...
%       0, 0, 1, 0;...
%       0, 1.3, 0, 1];
% T1 = [1, 0, 0, 0;... 
%       0, 0, 1, 0;...
%       0, 1, 0, 0;...
%       0, 0, 1.3, 1];
T1 = [1, 0, 0, 0;... 
      0, 0, 1, 0;...
      0, -1, 0, 0;...
      0, 0, 1.3, 1];
Tform1 = affine3d(T1);
% Frame transformation
pt3DMapTop = pctransform(ptCloudTop,Tform1);
% Display PCD file
figure(2);
pcshow(pt3DMapTop);
title('PCD of top camera position');

% Read pcd file of the top camera position of z=0.95[m] in the world frame
ptCloudMiddle = pcread('pcl1583215821.pcd');
figure(3);
pcshow(ptCloudMiddle);
title('Raw PCD of middle camera position');

% Set an affine matrix for the middle came position
% % T2 = [1, 0, 0, 0;... 
% %       0, 1, 0, 0;...
% %       0, 0, 1, 0;...
% %       0, 0.95, 0, 1];
T2 = [1, 0, 0, 0;... 
      0, 0, 1, 0;...
      0, 1, 0, 0;...
      0, 0, 0.95, 1];
T2 = [1, 0, 0, 0;... 
      0, 0, 1, 0;...
      0, -1, 0, 0;...
      0, 0, 0.95, 1];
Tform2 = affine3d(T2);
% Frame transformation
pt3DMapMiddle = pctransform(ptCloudMiddle,Tform2);
% Display PCD file
figure(4);
pcshow(pt3DMapMiddle);
title('PCD of middle camera position');

% Read pcd file of the top camera position of z=0.7[m] in the world frame
ptCloudBottom = pcread('pcl1583215857.pcd');
figure(5);
pcshow(ptCloudBottom);
title('Raw PCD of bottom camera position');
% z = 0.7[m]
% T3 = [1, 0, 0, 0;... 
%       0, 1, 0, 0;...
%       0, 0, 1, 0;...
%       0, 0.7, 0, 1];
T3 = [1, 0, 0, 0;... 
      0, 0, 1, 0;...
      0, 1, 0, 0;...
      0, 0, 0.7, 1];
T3 = [1, 0, 0, 0;... 
      0, 0, 1, 0;...
      0, -1, 0, 0;...
      0, 0, 0.7, 1];
Tform3 = affine3d(T3);
% Frame transformation
ptSceneBottom = pctransform(ptCloudBottom,Tform3);
% Display PCD file
figure(6);
pcshow(ptSceneBottom);
title('PCD of bottom camera position');

% Merge of 3D Map
pt3Dmap = pcmerge(pt3DMapTop, pt3DMapMiddle, 0.001);
pt3Dmap = pcmerge(pt3Dmap, ptSceneBottom, 0.001);
% Save the merged PCD
pcwrite(pt3Dmap,'Merged3DMap.pcd', 'Encoding','compressed');

% Display
figure(7);
pcshow(pt3Dmap);
title('Merged PCD');

function [dx] = computeLS(h_constraint,dz, H, R)
% Ranjeeth KS, University of Calgary, Canada

dx = (inv(H'*inv(R)*H))*(H'*inv(R)*dz);

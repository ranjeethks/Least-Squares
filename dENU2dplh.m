function [dplh]= dENU2dplh(dx_ENU,lat,alt)

% Ranjeeth KS, University of Calgary, Canada

M=calcm(lat);
N=calcn(lat);

dp=dx_ENU(2)/(M + alt);
dl=dx_ENU(1)/((N + alt)*cos(lat));
dh=dx_ENU(3);

dplh = [dp dl dh];
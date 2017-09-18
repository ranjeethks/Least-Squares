function [Qp] = computeQp(h_constraint,H,Qr)
% Ranjeeth KS, University of Calgary, Canada

Qp = (inv(H'*inv(Qr)*H));


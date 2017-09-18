% Ranjeeth KS, University of Calgary, Canada

clc;
clear all;
close all;

[InpData epochs]= ReadData();


%%
%settings
settings.no_iterationsinLS = 5;
settings.task4check = 0; %Variable to check task 4 -combination of 5 worst DOP sats
settings.epochs = epochs; 
settings.method = 'curvi';
settings.h_constraint = 1; 
settings.num_states = 4; % number of unknown states
settings.alpha = 5/100; %confidence level 95%
settings.beta = 10/100; %power of the test level 90%
settings.sigma02 = 1;
settings.weightedDOP = 1;
%%
run=singlepoint(InpData,settings);

analysis(run);
%%

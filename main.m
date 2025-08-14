% This is the entry of the program to search the phase equilibrium pairs
% from the dataset derived from DFT 
% The input includes 
% - fp: filepath of dataset plain file in which data are separated by comma
% - epsilon: distance error threshold of chemical potential pairs 
% - kappa: display switch 
% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.04.30

clc;
clear all;
close all;

fp='T353_1.dat';
epsilon=1e-2;
kappa=true;

pairs=checkPoints(fp,epsilon,kappa);
disp(pairs);



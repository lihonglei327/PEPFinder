% This is the entry of the program to search the phase equilibrium pairs
% from the dataset derived from DFT 
% The input includes 
% - fp: filepath of dataset plain file in which data are separated by comma
% - epsilon: distance error threshold of chemical potential pairs 
% - omega: neighbor radius of chemical potential pairs
% - delta: minimal interval of indices of chemical potential pairs in the
% data sequence
% - kappa: display switch 
% author: Dr. Honglei Li
% ver: 1.0
% date: 2025.04.30

clc;
clear all;
close all;

fp='T353_1.dat';
epsilon=1e-2;
omega=5;
delta=3;
kappa=true;

pairs=checkPoints(fp,epsilon,omega,delta,kappa);
disp(pairs);



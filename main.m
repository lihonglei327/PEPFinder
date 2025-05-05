% This is the entry of the program to search the phase equilibrium pairs
% in the dataset derived from DFT for equition of state
% The input includes 
% - fp: filepath of dataset plain file in which data entries are separated by comma
% - epsilon: distance error threshold of chemical potential pairs 
% - omega: neighborhood radius of chemical potential pair
% - delta: minimal interval of indices of chemical potential pairs in the sequentially ordered dataset
% - kappa: display the scatter plot if true(default)
% author: Dr. Honglei Li
% version: 1.0
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


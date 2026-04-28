% Main_SpiralAscending.m
% 1. Simulate the DOBC, where at time "Attack_Time" an attack is injected.
% 2. Save the simulation in the file Attack.mat.
% 3. Optionally plot the graphs. 
%    If the file Attack.mat is already available, the plot section can be run directly. 

clear all;
clc;

% Adding directories
addpath('bin/');
addpath('bin/misc/');

% Loading simulation parameters
SimulationParameters;

% Controller parameters
ControllerParameters;

% Loading plant parameters
[m,J,rg_B,F1,F2] = PlantParameters("HEXANiemiec");  % HEXANiemiec, QUAD, OCTA
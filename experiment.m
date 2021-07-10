%% Kill them all!
clc;clear;
close all;
%% Initialize the configuration parameters

% It creates a config file
% TODO: upload it from .csv file
init;

%% Create a instance of HapticSetup object

haptic_setup = HapticSetup(config);

%% Experiment

haptic_setup.experiment();


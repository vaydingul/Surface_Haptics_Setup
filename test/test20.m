%% Kill them all!
clc; clear;
close all;
%% Initialize the configuration parameters

% It creates a config file
init;

%% Create a instance of HapticSetup object

haptic_setup = HapticSetup(config);

%% Start the simulation

haptic_setup.start()

%% Activate the controller

haptic_setup.is_control_active = 1;

%! Check whether simulink displays for accuracy of the positions

%% Kill the simulation
haptic_setup.kill();

% OK
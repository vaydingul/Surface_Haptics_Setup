%% Kill them all!
clc;clear;
%% Initialize the configuration parameters

% It creates a config file
% TODO: upload it from .csv file
init;

%% Create a instance of HapticSetup object

haptic_setup = HapticSetup(config);

%% Custom 

haptic_setup.start_simulation();

%% Custom

haptic_setup.connect_motors();
%% Custom

% Set the limits of the travelling trajectory
x1 = min(obj.config.initial_horizontal_position + obj.config.delta_x, obj.config.max_travel_safety_horizontal - 10); % 95
x2 = max(obj.config.initial_horizontal_position - obj.config.delta_x, 10); % 55

%% Custom


obj.move_horizontal_motor_to_position(x1);

%% Custom

haptic_setup.forward_pass(x1, x2)
%% Custom



%% Custom
%% Experiment

haptic_setup.experiment();


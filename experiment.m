%% Kill them all!
clc;clear;
close all;
%% Initialize the configuration parameters

% It creates a config file
% TODO: upload it from .csv file
init;

%% Create a instance of HapticSetup object

haptic_setup = HapticSetup(config);

%%

%% Experiment

haptic_setup.experiment();

%% Plot

ffnn = fn.signals.values(state.signals.values == 1);
plot([ffnn ones(length(ffnn), 1)*0.5]);
%%

haptic_setup.move_horizontal_motor_to_position(0)
haptic_setup.home_motors()
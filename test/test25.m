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


%% Control the normal force
haptic_setup.control();

haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.x2)

%% One straight backward pass

haptic_setup.backward_pass();

%% Kill the simulation
haptic_setup.kill();

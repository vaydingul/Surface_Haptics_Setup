%% Kill them all!
clc;clear;
close all;
%% Initialize the configuration parameters

% It creates a config file
% TODO: upload it from .csv file
init_2018;

%% Create a instance of HapticSetup object

haptic_setup = HapticSetup(config);

%%

%% Start experiment
haptic_setup.start(); 

%% Open the control

haptic_setup.is_control_active = 1;
%% Control the normal force

haptic_setup.control(); 

%% Main experiment

i = 1;
while (i <= haptic_setup.config.number_of_slidings)

	haptic_setup.current_sliding_iteration = i;

	current_velocity = haptic_setup.config.sliding_velocity(i);

	haptic_setup.set_velocity_horizontal_motor(current_velocity, 20);

	haptic_setup.finger_relaxation();

	haptic_setup.forward_pass_continuous()

	haptic_setup.finger_relaxation();

	haptic_setup.backward_pass_continuous()

	i = i + 1

end

haptic_setup.kill();

%% Plot

%ffnn = fn.signals.values(state.signals.values == 1);
%plot([ffnn ones(length(ffnn), 1)*0.5]);
%%

%haptic_setup.move_horizontal_motor_to_position(0)
%haptic_setup.home_motors()
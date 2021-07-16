%% Kill them all!
clc;clear;
close all;
%% Initialize the configuration parameters

% It creates a config file
init;

%% Create a instance of HapticSetup object

haptic_setup = HapticSetup(config);

%% Start the simulation

haptic_setup.start_simulation();

%% Connect the motors

haptic_setup.connect_motors();

%% Set velocity for the motors;

haptic_setup.set_velocity_horizontal_motor(20, 5);
haptic_setup.set_velocity_vertical_motor(20, 5);


%% Move the motors to initial position

haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.initial_horizontal_position);
haptic_setup.move_vertical_motor_to_position(haptic_setup.config.initial_vertical_position);
            

%% Forward pass of the horizontal motor

haptic_setup.forward_pass_();



%! Check whether simulink displays for accuracy of the positions

%% Don't forget to disconnect the motors

haptic_setup.disconnect_motors();

%% Don't forget to close the simulation

haptic_setup.stop_simulation();


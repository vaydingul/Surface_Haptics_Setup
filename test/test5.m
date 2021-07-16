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

haptic_setup.set_velocity_horizontal_motor(10, 10);
haptic_setup.set_velocity_vertical_motor(10, 10);


%% Move the motors to initial position

haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.initial_horizontal_position);
haptic_setup.move_vertical_motor_to_position(haptic_setup.config.initial_vertical_position);
            

%% Move horizontal motor arbitrarily

haptic_setup.move_horizontal_motor_to_position(10);
haptic_setup.move_horizontal_motor_to_position(50);

%% Move vertical motor arbitrarily

haptic_setup.move_vertical_motor_to_position(10);
haptic_setup.move_vertical_motor_to_position(50);

%! Check whether simulink displays for accuracy of the positions
%! Also, check from the workspace

%% Don't forget to disconnect the motors

haptic_setup.disconnect_motors();

%% Don't forget to close the simulation

haptic_setup.stop_simulation();
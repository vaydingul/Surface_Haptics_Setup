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

haptic_setup.move_horizontal_motor_to_position(0);
haptic_setup.move_vertical_motor_to_position(0);
            

%% Continuous movement of both motors for 1 sec.

haptic_setup.move_horizontal_motor_continuous(1);
haptic_setup.move_vertical_motor_continuous(1);

% Wait for 1 second
pause(2.0);

% Change the velocity of the motor without stopping it
haptic_setup.set_velocity_horizontal_motor(20,20);
haptic_setup.set_velocity_vertical_motor(20,20);

haptic_setup.move_horizontal_motor_continuous(1);
haptic_setup.move_vertical_motor_continuous(1);
% Wait for 1 second
pause(1.0);

% Stop it
haptic_setup.stop_horizontal_motor();
haptic_setup.stop_vertical_motor();

%! Check whether simulink displays for accuracy of the positions

%% Don't forget to disconnect the motors

haptic_setup.disconnect_motors();

%% Don't forget to close the simulation

haptic_setup.stop_simulation();

% OK
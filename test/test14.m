%% Kill them all!
clc; clear;
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

haptic_setup.set_velocity_horizontal_motor(10, 5);
haptic_setup.set_velocity_vertical_motor(10, 5);

%% Move the motors to initial position

haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.initial_horizontal_position);
haptic_setup.move_vertical_motor_to_position(haptic_setup.config.initial_vertical_position);

%% Forward pass of the horizontal motor

haptic_setup.status = 0;
haptic_setup.update();

haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.x1);
haptic_setup.set_velocity_horizontal_motor(10, 1);

haptic_setup.status = 1;
haptic_setup.update();

haptic_setup.move_horizontal_motor_continuous(-1);

while haptic_setup.motor_horizontal_position >= haptic_setup.config.x2
    
    disp(num2str(haptic_setup.motor_horizontal_position))
    haptic_setup.update();
    haptic_setup.controller_step();
    
end

haptic_setup.stop_horizontal_motor();
haptic_setup.update();
%! Check whether simulink displays for accuracy of the positions

%% Don't forget to disconnect the motors

haptic_setup.disconnect_motors();

%% Don't forget to close the simulation

haptic_setup.stop_simulation();

% OK

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

%% Check if the motors are connected

if haptic_setup.is_motor_horizontal_connected && haptic_setup.is_motor_vertical_connected
    
    disp("It looks like the motors are connected!")

end
%% Home them

haptic_setup.home_motors();

%! Check whether the motors work properly

%% Don't forget to disconnect the motors

haptic_setup.disconnect_motors();

%% Don't forget to close the simulation

haptic_setup.stop_simulation();


% OK
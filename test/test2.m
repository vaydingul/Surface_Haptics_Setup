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

if haptic_setup.is_simulation_running

	disp("It looks like simulation is running!")

end
%! Check whether the simulink file is started properly


%% Don't forget to close the simulation

haptic_setup.stop_simulation();


% OK
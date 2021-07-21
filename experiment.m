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

haptic_setup.is_control_active = 0;
%% Control the normal force

haptic_setup.control(); 

%% Control check iteration

haptic_setup.config.pid_tuning_trial = 50;
%% Main experiment
i = 1;
while (i <= haptic_setup.config.number_of_slidings)

    haptic_setup.current_sliding_iteration = i;
    
    current_velocity = haptic_setup.config.sliding_velocity(i);
    
    haptic_setup.set_velocity_horizontal_motor(current_velocity, 10);
    
    haptic_setup.finger_relaxation();
    haptic_setup.control();
    
    haptic_setup.forward_pass_continuous()
    
    haptic_setup.finger_relaxation();
%     haptic_setup.control();
    
    haptic_setup.backward_pass_continuous()

	i = i + 1

end

%% Kill the process
haptic_setup.kill();


%% Save the results

mkdir('results')
filename = ['results/experimental_results' strrep(strrep(datestr(datetime('now')), ' ', '_'), ':', '') '.mat'];
save(filename, 'horizontal_position', 'vertical_position', 'fn', 'fy', 'status', 'haptic_setup');

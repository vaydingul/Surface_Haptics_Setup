% Construction of the config struct


%% Parameters

% Experiment parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
config.participant_name = 'VolkanTrialSeries';
config.number_of_slidings = 1; % How many sliding there will be in the experiment
config.simulation_name = 'experimentSim_2018a';
config.sample_time = 1 / 2500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Electrovibration parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
config.normal_force = 0.5; % Desired normal force for the PID controller
config.waveform = 'AC'; % Is it AC or DC?
config.amplitude = 200; % Peak to peak voltage signal amplitude
config.frequency = 125; % Signal frequency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Motor parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Serials of the motors
config.horizontal_serial_number = '45878141';
config.vertical_serial_number = '45878213';

% Motor instantiations
config.motor_horizontal = motor();
config.motor_vertical = motor();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Constants
config.delta_x = 20; % Step movement of the stages(-20,0,20)
config.initial_vertical_position = 55; % Initial vertical position
config.initial_horizontal_position = 75; % Initial vertical position
config.max_travel_safety_vertical = config.initial_vertical_position + 13;
config.max_travel_safety_horizontal = 120; % Max travel point of stage safety limitation horizntal
config.max_velocity_safety = 50; %max vertical and horizontal stage current_velocity limitation
config.max_acceleration_safety = 50; %max acceleration and horizontal stage current_velocity limitation
config.min_velocity_safety = 5;
config.min_acceleration_safety = 5;
config.minimum_acceleration = 0.000111; %min acceleration and horizontal stage current_velocity limitation
config.maximum_acceleration = 50;
config.initial_pid_tuning_trial = 200;
config.relaxation_distance = 10;
config.relaxation_duration = 1;

% Set the limits of the travelling trajectory
config.x1 = min(config.initial_horizontal_position + config.delta_x, config.max_travel_safety_horizontal - 10); % 95
config.x2 = max(config.initial_horizontal_position - config.delta_x, 10); % 55

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Butterworth filter design

% Butterworth filter parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
config.butterworth_order = 4;
config.butterworth_cutoff_frequency = 50;
config.butterworth_sampling_frequency = 2500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[config.butterworth_b, config.butterworth_a] = butter(config.butterworth_order, config.butterworth_cutoff_frequency / (config.butterworth_sampling_frequency / 2)); % Butterwort

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

config.sliding_velocity = [40];
%% condition

config.condition = [1.0000    0.0000    0.5000];
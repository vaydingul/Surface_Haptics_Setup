classdef HapticSetup < handle
    %HAPTICSETUP General class that operates the surface haptics setup
    %   Detailed explanation goes here
    
    properties
        config

        motor_horizontal_position = 0;
        motor_vertical_position = 0;
        
        current_sliding_iteration = 1;
        
        controller_output_runtime_object
        controller_output = 0;
        
        state
        status = 0;
    end
   
    methods
        
        function obj = HapticSetup(config)
            
            obj.config = config;
            obj.current_sliding_iteration = 1;
            obj.status = 0;
            obj.state = InitState();
        end
        
        function [] = start_simulation(obj)
            
            set_param(obj.config.simulation_name, 'SimulationCommand', 'start');
            obj.controller_output_runtime_object = get_param([obj.config.simulation_name, '/', 'pid_output_saturated'], 'RuntimeObject');
            
        end
        
        function [] = stop_simulation(obj)
            
            set_param(obj.config.simulation_name, 'SimulationCommand', 'stop');
            
            
        end
        
        function [] = connect_horizontal_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            connect(obj.config.motor_horizontal, obj.config.horizontal_serial_number);
            
        end
        
        function [] = connect_vertical_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            connect(obj.config.motor_vertical, obj.config.vertical_serial_number);
        end
        
        function [] = connect_motors(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            obj.connect_horizontal_motor();
            obj.connect_vertical_motor();
            obj.update();
        end
        
        function [] = disconnect_horizontal_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            disconnect(obj.config.motor_horizontal);
            
        end
        
        function [] = disconnect_vertical_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            disconnect(obj.config.motor_vertical);
        end
        
        function [] = disconnect_motors(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            obj.disconnect_horizontal_motor();
            obj.disconnect_vertical_motor();
            obj.update();
        end
        
        function [] = move_horizontal_motor_to_position(obj, position_x)
            
            moveto(obj.config.motor_horizontal, position_x);
            obj.update();
            
        end
        
        function [] = move_vertical_motor_to_position(obj, position_y)
            
            moveto(obj.config.motor_vertical, position_y);
            obj.update();
            
        end
        
        
        function [] = stop_horizontal_motor(obj)
            
            stop(obj.config.motor_horizontal);
            obj.update();
            
        end
        
        function [] = stop_vertical_motor(obj)
            
            stop(obj.config.motor_vertical);
            obj.update();
            
        end
        
        function [] = stop_motors(obj)
            
            obj.stop_vertical_motor();
            obj.stop_horizontal_motor();
            obj.update();
            
        end
        
        function [] = home_horizontal_motor(obj)
            
            home(obj.config.motor_horizontal);
            obj.update();
            
        end
        
        function [] = home_vertical_motor(obj)
            
            home(obj.config.motor_vertical);
            obj.update();
            
        end
        
        function [] = home_motors(obj)
            
            obj.home_horizontal_motor();
            obj.home_vertical_motor();
            obj.update();
            
        end
        
        function [] = set_velocity_horizontal_motor(obj, velocity, acceleration)
            
            setvelocity(obj.config.motor_horizontal,  velocity, acceleration)
            obj.update();
            
        end
        
        function [] = set_velocity_vertical_motor(obj, velocity, acceleration)
            
            setvelocity(obj.config.motor_vertical, velocity, acceleration)
            obj.update();
            
        end
        
        function [] = move_horizontal_motor_continuous(obj, dir)
            
            if dir == 1
                
                movecont(obj.config.motor_horizontal);
                
            elseif dir == -1
                
                movecont(obj.config.motor_horizontal, dir);
                
            else
                
                disp('Please type 1 for forward, -1 for backward!');
                
            end
            
            obj.update();
            
        end
        
        function [] = move_vertical_motor_continuous(obj, dir)
            
            if dir == 1
                
                movecont(obj.config.motor_vertical);
                
            elseif dir == -1
                
                movecont(obj.config.motor_vertical, dir);
                
            else
                
                disp('Please type 1 for forward, -1 for backward!');
                
            end
            
            obj.update();
            
        end
        
        function obj = update(obj)
            
            obj.motor_horizontal_position = obj.config.motor_horizontal.position;
            obj.motor_vertical_position = obj.config.motor_vertical.position;
            obj.controller_output = obj.controller_output_runtime_object.InputPort(1).Data;
            set_param([obj.config.simulation_name '/' 'State'], 'Value', num2str(obj.status));
            set_param([obj.config.simulation_name '/' 'vertical_position'], 'Value', num2str(obj.config.motor_vertical.position));
            set_param([obj.config.simulation_name '/' 'horizontal_position'], 'Value', num2str(obj.config.motor_horizontal.position));
            
        end
        
        function [] = forward_pass(obj, x1, x2)
            
            obj.state = 1;
            obj.update();
            obj.move_horizontal_motor_to_position(x1);
            obj.move_horizontal_motor_to_position(x2);

        end
        
        function [] = backward_pass(obj, x1, x2)
            
            obj.state = 0;
            obj.update();
            obj.move_horizontal_motor_to_position(x2);
            obj.move_horizontal_motor_to_position(x1);
            
        end

        function [] = forward_pass_with_control(obj, x1, x2)
            
            obj.state = 1;
            obj.update();
            obj.move_horizontal_motor_to_position(x1);
            obj.move_horizontal_motor_to_position(x2);

        end
        
        function [] = backward_pass_with_control(obj, x1, x2)
            
            obj.state = 0;
            obj.update();
            obj.move_horizontal_motor_to_position(x2);
            obj.move_horizontal_motor_to_position(x1);
            
        end
        
        function [] = controller_step(obj)
            
            obj.state = 0;
            obj.update();
            % If the stage is below the safe travel limit
            if (obj.motor_vertical_position < (obj.config.max_travel_safety_vertical))
                
                % Set current_velocity of the vertical stage based on the PID output
                vel = -sign(obj.controller_output);
                
                % Check if it is zero.
                if (vel == 0), vel = 1; end
                
                obj.set_velocity_vertical_motor(vel * max(abs(obj.controller_output) / 10, obj.config.minimum_acceleration), max(abs(obj.controller_output), obj.config.minimum_acceleration));
                
            else
                
                obj.set_velocity_vertical_motor(-1, 10);
                
            end
            
            pause(.1);
            
            obj.move_vertical_motor_continuous(1);
            
            
        end
        
        function [] = finger_relaxation(obj)
            
            obj.state = 0;
            obj.update();
            
            obj.set_velocity_vertical_motor(obj.config.max_velocity_safety, obj.config.max_acceleration_safety)
            obj.move_vertical_motor_to_position(obj.motor_vertical_position + obj.config.relaxation_distance);
            pause(obj.config.relaxation_duration);
            obj.move_vertical_motor_to_position(obj.motor_vertical_position - obj.config.relaxation_distance);
            obj.set_velocity_vertical_motor(obj.config.min_velocity_safety, obj.config.min_acceleration_safety)
            
            
        end
        
        function [] = experiment(obj)
            
            obj.start_simulation();
            disp("Simulation started!");
            % It connects to both vertical and horizontal motor
            obj.connect_motors();
            disp("Motors are connected!");
            
            % obj.home_motors();
            disp("Motors are home!");
            
            % Move motors to the initial point
            
            obj.move_horizontal_motor_to_position(obj.config.initial_horizontal_position);
            obj.move_vertical_motor_to_position(obj.config.initial_vertical_position);
            disp("Stages are located to their initial positions!");
            
            
            
            i = 0;
            disp("Force control started!");
            while (i < obj.config.initial_pid_tuning_trial)
                
                obj.controller_step();
                
                i = i + 1
            end
            obj.stop_vertical_motor();
            disp("Force control finished!");
            
            % Set the limits of the travelling trajectory
            x1 = min(obj.config.initial_horizontal_position + obj.config.delta_x, obj.config.max_travel_safety_horizontal - 10); % 95
            x2 = max(obj.config.initial_horizontal_position - obj.config.delta_x, 10); % 55
            
            obj.move_horizontal_motor_to_position(x1);
            
            i = 1;
            
            while (i <= obj.config.number_of_slidings)
                
                obj.current_sliding_iteration = i;
                
                current_velocity = obj.config.sliding_velocity(i);
                
                obj.set_velocity_horizontal_motor(current_velocity);
                
                
                obj.finger_relaxation();
                obj.update();
                
                obj.forward_pass(x1, x2);
                obj.update();
                
                k = 0;
                disp("Force control started!");
                while (k < int32(obj.config.initial_pid_tuning_trial/4))
                    
                    obj.controller_step();
                    
                    k = k + 1
                end
                obj.stop_vertical_motor();
                disp("Force control finished!");
                
                obj.finger_relaxation();
                obj.update();
                
                obj.backward_pass(x1, x2);
                obj.update();
                
                k = 0;
                disp("Force control started!");
                while (k < int32(obj.config.initial_pid_tuning_trial/4))
                    
                    obj.controller_step();
                    
                    k = k + 1
                end
                obj.stop_vertical_motor();
                disp("Force control finished!");
                
                i = i + 1;
                
                
                
            end
            
            obj.disconnect_motors();
            
            
            obj.stop_simulation();
            
        end
        
    end
    
    methods (Static)
        
        function [] = set_velocity(motor_, varargin)
            
            setvelocity(motor_, varargin)
            
        end
        
        function [] = move_motor_to_position(motor_, position)
            
            moveto(motor_, position);
            
        end
        
        function [] = move_motor_continuous(motor_, dir)
            
            if dir == 1
                
                movecont(motor_);
                
            elseif dir == -1
                
                movecont(motor_, dir);
                
            else
                
                disp('Please type 1 for forward, -1 for backward!');
                
            end
            
        end
        
    end
    
end

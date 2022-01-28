classdef HapticSetup < handle
    %HAPTICSETUP General class that operates the surface haptics setup
    %   Detailed explanation goes here
    
    properties
        
        config
        
        motor_horizontal;
        motor_vertical;
        
        is_motor_horizontal_connected = 0;
        is_motor_vertical_connected = 0;
        
        motor_horizontal_position = 0;
        motor_vertical_position = 0;
        
        is_simulation_running = 0;
        current_sliding_iteration = 1;
        
        controller_output_runtime_object
        controller_output = 0;
        
        is_control_active = 0;
        
        state
        status = 0;
        
    end
    
    methods
        
        function obj = HapticSetup(config)
            
            obj.config = config;
            obj.current_sliding_iteration = 1;
            obj.motor_vertical = config.motor_vertical;
            obj.motor_horizontal = config.motor_horizontal;
            obj.status = 0;
            obj.state = InitState();
        end
        
        function [] = start_simulation(obj)
            
            set_param(obj.config.simulation_name, 'SimulationCommand', 'start');
            obj.controller_output_runtime_object = get_param([obj.config.simulation_name, '/', 'pid_output_saturated'], 'RuntimeObject');
            obj.is_simulation_running = 1;
            set_param([obj.config.simulation_name '/' 'camera_trigger'], 'Value', num2str(0)); 
            disp("Simulation started!");
            
        end
        
        function [] = stop_simulation(obj)
            
            set_param(obj.config.simulation_name, 'SimulationCommand', 'stop');
            obj.is_simulation_running = 0;
            
        end
        
        function [] = connect_horizontal_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            connect(obj.motor_horizontal, obj.config.horizontal_serial_number);
            obj.is_motor_horizontal_connected = 1;
        end
        
        function [] = connect_vertical_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            connect(obj.motor_vertical, obj.config.vertical_serial_number);
            obj.is_motor_vertical_connected = 1;
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
            disconnect(obj.motor_horizontal);
            obj.is_motor_horizontal_connected = 0;
            
        end
        
        function [] = disconnect_vertical_motor(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            disconnect(obj.motor_vertical);
            obj.is_motor_vertical_connected = 0;
            
        end
        
        function [] = disconnect_motors(obj)
            %CONNECT_HORIZONTAL_MOTOR Connect to the horizontal motor
            %   Detailed explanation goes here
            obj.disconnect_horizontal_motor();
            obj.disconnect_vertical_motor();
        end
        
        function [] = stop_horizontal_motor(obj)
            
            stop(obj.motor_horizontal);
            obj.update();
            
        end
        
        function [] = stop_vertical_motor(obj)
            
            stop(obj.motor_vertical);
            obj.update();
            
        end
        
        function [] = stop_motors(obj)
            
            obj.stop_vertical_motor();
            obj.stop_horizontal_motor();
            obj.update();
            
        end
        
        function [] = home_horizontal_motor(obj)
            
            home(obj.motor_horizontal);
            obj.update();
            
        end
        
        function [] = home_vertical_motor(obj)
            
            home(obj.motor_vertical);
            obj.update();
            
        end
        
        function [] = home_motors(obj)
            
            obj.home_horizontal_motor();
            obj.home_vertical_motor();
            obj.update();
            
        end
        
        function [] = move_horizontal_motor_to_position(obj, position_x)
            
            moveto(obj.motor_horizontal, position_x);
            obj.update();
            
        end
        
        function [] = move_vertical_motor_to_position(obj, position_y)
            
            moveto(obj.motor_vertical, position_y);
            obj.update();
            
        end
        
        function [] = set_velocity_horizontal_motor(obj, velocity, acceleration)
            
            setvelocity(obj.motor_horizontal, velocity, acceleration)
            obj.update();
            
        end
        
        function [] = set_velocity_vertical_motor(obj, velocity, acceleration)
            
            setvelocity(obj.motor_vertical, velocity, acceleration)
            obj.update();
            
        end
        
        function [] = move_horizontal_motor_continuous(obj, dir)
            
            if dir == 1
                
                movecont(obj.motor_horizontal);
                
            elseif dir == -1
                
                movecont(obj.motor_horizontal, dir);
                
            else
                
                disp('Please type 1 for forward, -1 for backward!');
                
            end
            
            obj.update();
            
        end
        
        function [] = move_vertical_motor_continuous(obj, dir)
            
            if dir == 1
                
                movecont(obj.motor_vertical);
                
            elseif dir == -1
                
                movecont(obj.motor_vertical, dir);
                
            else
                
                disp('Please type 1 for forward, -1 for backward!');
                
            end
            
            obj.update();
            
        end
        
        function obj = update(obj)
            
            if obj.is_motor_horizontal_connected
                obj.motor_horizontal.updatestatus();
                obj.motor_horizontal_position = obj.motor_horizontal.position;
            end
            if obj.is_motor_vertical_connected
                obj.motor_vertical.updatestatus();
                obj.motor_vertical_position = obj.motor_vertical.position;
            end
            
            if obj.is_simulation_running
                obj.controller_output = obj.controller_output_runtime_object.InputPort(1).Data;
                
                
                set_param([obj.config.simulation_name '/' 'status'], 'Value', num2str(obj.status));
                set_param([obj.config.simulation_name '/' 'vertical_position'], 'Value', num2str(obj.motor_vertical.position));
                set_param([obj.config.simulation_name '/' 'horizontal_position'], 'Value', num2str(obj.motor_horizontal.position));
            end
        end
        
        function [] = forward_pass_(obj)
            
            obj.status = 0;
            obj.update();
            
            obj.move_horizontal_motor_to_position(obj.config.x1);
            
            obj.status = 1;
            obj.update();
            
            obj.move_horizontal_motor_to_position(obj.config.x2);
            
            obj.status = 0;
            obj.update();
        end
        
        function [] = backward_pass_(obj)
            
            obj.status = 0;
            obj.update();
            
            obj.move_horizontal_motor_to_position(obj.config.x2);
            
            obj.status = 2;
            obj.update();
            
            obj.move_horizontal_motor_to_position(obj.config.x1);
            
            obj.status = 0;
            obj.update();
        end
        
        function [] = forward_pass_continuous_(obj)
            
            obj.status = 0;
            obj.update();
            
            obj.move_horizontal_motor_to_position(obj.config.x1);
            
            obj.status = 1;
            obj.update();
            
            obj.move_horizontal_motor_continuous(-1);
            
            while obj.motor_horizontal_position >= obj.config.x2
                
                %disp(num2str(obj.motor_horizontal_position))
                obj.update();
                obj.controller_step();
                
            end
            
            obj.status = 0;
            obj.update();
            
            if obj.is_control_active
                obj.stop_motors();
            else
                obj.stop_horizontal_motor();
            end
            
            
            
        end
        
        function [] = backward_pass_continuous_(obj)
            
            obj.status = 0;
            obj.update();
            
            obj.move_horizontal_motor_to_position(obj.config.x2);
            
            obj.status = 2;
            obj.update();
            
            obj.move_horizontal_motor_continuous(1);
            
            while obj.motor_horizontal_position <= obj.config.x1
                
                %disp(num2str(obj.motor_horizontal_position))
                obj.update();
                obj.controller_step();
                
            end
            
            obj.status = 0;
            obj.update();
            
            if obj.is_control_active
                obj.stop_motors();
            else
                obj.stop_horizontal_motor();
            end
            
            
            
            
        end
        
        function [] = controller_step(obj)
            
            obj.update();
            
            if obj.is_control_active
                
                
                % Set current_velocity of the vertical stage based on the PID output
                vel = -sign(obj.controller_output);
                
                % Check if it is zero.
                if (vel == 0), vel = 1; end
                
                %                obj.set_velocity_vertical_motor(vel * max(abs(obj.controller_output) / 10, obj.config.minimum_acceleration), max(abs(obj.controller_output), obj.config.minimum_acceleration));
                obj.set_velocity_vertical_motor(vel * min(abs(obj.controller_output) / 10, 1), 50);
                %                 obj.set_velocity_vertical_motor(vel * 0.1, 50);
                
                
                pause(.05);
                
                obj.move_vertical_motor_continuous(1);
                
                pause(.05);
            end
            
        end
        
        function [] = controller_step_multiple(obj)
            
            if obj.is_control_active
                
                obj.status = 3;
                obj.update();
                
                
                i = 1;
                while (i < obj.config.pid_tuning_trial)
                    
                    obj.controller_step();
                    
                    i = i + 1;
                end
                
                obj.status = 0;
                obj.update();
                
                obj.stop_vertical_motor();
                
            end
            
        end
        
        function [] = finger_relaxation_(obj)
            
            obj.status = 4;
            obj.update();
            
            obj.set_velocity_vertical_motor(obj.config.max_velocity_safety, obj.config.max_acceleration_safety)
            obj.move_vertical_motor_to_position(obj.motor_vertical_position + obj.config.relaxation_distance);
            pause(obj.config.relaxation_duration);
            obj.move_vertical_motor_to_position(obj.motor_vertical_position - obj.config.relaxation_distance);
            obj.set_velocity_vertical_motor(obj.config.min_velocity_safety, obj.config.min_acceleration_safety)
            
            obj.status = 0;
            obj.update();
        end
        
        function [] = take_photograph(obj)
           
           set_param([obj.config.simulation_name '/' 'camera_trigger'], 'Value', num2str(3)); 
           set_param([obj.config.simulation_name '/' 'camera_trigger'], 'Value', num2str(0)); 

            
        end
        
        
        function [] = start(obj)
            
            obj.state.start(obj);
            
        end
        
        function [] = stop(obj)
            
            obj.state.stop(obj);
            
        end
        
        function [] = kill(obj)
            
            obj.state.kill(obj);
            
        end
        
        function [] = forward_pass_continuous(obj)
            
            obj.state.forward_pass_continuous(obj);
            
        end
        
        function [] = backward_pass_continuous(obj)
            
            obj.state.backward_pass_continuous(obj);
            
        end
        
        function [] = forward_pass(obj)
            
            obj.state.forward_pass(obj);
            
        end
        
        function [] = backward_pass(obj)
            
            obj.state.backward_pass(obj);
            
        end
        
        function [] = finger_relaxation(obj)
            
            obj.state.finger_relaxation(obj);
            
        end
        
        function [] = control(obj)
            
            obj.state.control(obj);
            
        end
        
        function [] = set_velocity(motor_, velocity, acceleration)
            
            setvelocity(motor_, velocity, acceleration)
            
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

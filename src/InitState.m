classdef InitState < State

    methods

        function start(obj, haptic_setup)

            haptic_setup.start_simulation();
            haptic_setup.connect_motors();
            % Move motors to the initial point

            haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.initial_horizontal_position);
            haptic_setup.move_vertical_motor_to_position(haptic_setup.config.initial_vertical_position);
            
            haptic_setup.move_horizontal_motor_to_position(haptic_setup.config.x1);

            haptic_setup.state = IdleState();

        end

        function stop(obj, haptic_setup)

            warning('It is not recommended to stop() in INIT state.')
            haptic_setup.state = IdleState()

        end

        function kill(obj, haptic_setup)

            warning('It is not recommended to kill() in INIT state.')
            haptic_setup.disconnect_motors()
            haptic_setup.stop_simulation();
            haptic_setup.state = IdleState()

        end

<<<<<<< HEAD:src/InitState.m
        function forward_pass_continuous(haptic_setup)
=======
        function forward_pass_with_control(obj, haptic_setup)

            error('It is not recommended to forward_pass_with_control() in INIT state.')
>>>>>>> 336e1172863d051cfdb3f574fff505dddbf7530e:InitState.m

            error('It is not recommended to forward_pass_continuous() in INIT state.')
            
        end

<<<<<<< HEAD:src/InitState.m
        function backward_pass_continuous(haptic_setup)
=======
        function backward_pass_with_control(obj, haptic_setup)
>>>>>>> 336e1172863d051cfdb3f574fff505dddbf7530e:InitState.m

            error('It is not recommended to backward_pass_continuous() in INIT state.')

        end

        function forward_pass(obj, haptic_setup)

            error('It is not recommended to forward_pass() in INIT state.')

        end

        function backward_pass(obj, haptic_setup)

            error('It is not recommended to backward_pass() in INIT state.')

        end

        function finger_relaxation(obj, haptic_setup)

            error('It is not recommended to finger_relaxation() in INIT state.')

        end

        function control(obj, haptic_setup)

            error('It is not recommended to control() in INIT state.')

        end

    end

end

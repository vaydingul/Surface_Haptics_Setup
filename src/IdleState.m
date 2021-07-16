classdef IdleState < State

    methods

        function start(obj, haptic_setup)

            warning('Setup might already been initialized and started.')
            

            if ~ haptic_setup.is_motor_horizontal_connected
                haptic_setup.connect_horizontal_motor();
            end

            if ~ haptic_setup.is_motor_vertical_connected
                haptic_setup.connect_vertical_motor();
            end

            if ~ haptic_setup.is_simulation_running
                haptic_setup.start_simulation();
            end

            haptic_setup.state = IdleState();


        end

        function stop(obj, haptic_setup)

            warning('There are no moving parts yet!')

        end

        function kill(obj, haptic_setup)
            
            warning('Goodbye, Father!')
            haptic_setup.disconnect_motors()
            haptic_setup.stop_simulation();

        end

<<<<<<< HEAD:src/IdleState.m
        function forward_pass_continuous(haptic_setup)
=======
        function forward_pass_with_control(obj, haptic_setup)
>>>>>>> 336e1172863d051cfdb3f574fff505dddbf7530e:IdleState.m

            warning('It is being switched to the FORWARD_PASS_WITH_CONTROL state. Please make sure that the initial control phase is completed.')
            haptic_setup.forward_pass_continuous_();
            haptic_setup.state = ForwardPassContinuousState();

        end

<<<<<<< HEAD:src/IdleState.m
        function backward_pass_continuous(haptic_setup)
=======
        function backward_pass_with_control(obj, haptic_setup)
>>>>>>> 336e1172863d051cfdb3f574fff505dddbf7530e:IdleState.m

            warning('It is being switched to the BACKWARD_PASS_WITH_CONTROL state. Please make sure that the initial control phase is completed.')
            haptic_setup.backward_pass_continuous_();
            haptic_setup.state = BackwardPassContinuousState();

        end

        function forward_pass(obj, haptic_setup)

            warning('It is being switched to the FORWARD_PASS state. Please make sure that the initial control phase is completed.')
            haptic_setup.forward_pass_();
            haptic_setup.state = ForwardPassState();

        end

        function backward_pass(obj, haptic_setup)

            warning('It is being switched to the BACKWARD_PASS state. Please make sure that the initial control phase is completed.')
            haptic_setup.backward_pass_();
            haptic_setup.state = BackwardPassState();

        end

        function finger_relaxation(obj, haptic_setup)

            haptic_setup.finger_relaxation_();
            haptic_setup.state = FingerRelaxationState();

        end

        function control(obj, haptic_setup)

            haptic_setup.controller_step_multiple();
            haptic_setup.state = ControlState();

        end

    end

end

classdef IdleState < State

    methods

        function start(obj, haptic_setup)

            warning('Setup has already been initialized and started.')

        end

        function stop(obj, haptic_setup)

            warning('There are no moving parts yet!')

        end

        function kill(obj, haptic_setup)
            
            warning('Goodbye, Father!')
            haptic_setup.disconnect_motors()
            haptic_setup.stop_simulation();

        end

        function forward_pass_with_control(obj, haptic_setup)

            warning('It is being switched to the FORWARD_PASS_WITH_CONTROL state. Please make sure that the initial control phase is completed.')
            haptic_setup.state = ForwardPassWithControlState();
            haptic_setup.forward_pass_with_control_();

        end

        function backward_pass_with_control(obj, haptic_setup)

            warning('It is being switched to the BACKWARD_PASS_WITH_CONTROL state. Please make sure that the initial control phase is completed.')
            haptic_setup.state = BackwardPassWithControlState();
            haptic_setup.backward_pass_with_control_();

        end

        function forward_pass(obj, haptic_setup)

            warning('It is being switched to the FORWARD_PASS state. Please make sure that the initial control phase is completed.')
            haptic_setup.state = ForwardPassState();
            haptic_setup.forward_pass_();

        end

        function backward_pass(obj, haptic_setup)

            warning('It is being switched to the BACKWARD_PASS state. Please make sure that the initial control phase is completed.')
            haptic_setup.state = BackwardPassState();
            haptic_setup.backward_pass_();

        end

        function finger_relaxation(obj, haptic_setup)

            haptic_setup.state = FingerRelaxationState();
            haptic_setup.finger_relaxation_();

        end

        function control(obj, haptic_setup)

            haptic_setup.state = ControlState();
            haptic_setup.controller_step_multiple();

        end

    end

end

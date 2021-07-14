classdef InitState < State

    methods

        function start(haptic_setup)

            haptic_setup.start_simulation();
            haptic_setup.connect_motors();
            haptic_setup.state = IdleState();

        end

        function stop(haptic_setup)

            warning('It is not recommended to stop() in INIT state.')
            haptic_setup.state = IdleState()

        end

        function kill(haptic_setup)

            warning('It is not recommended to kill() in INIT state.')
            haptic_setup.state = IdleState()

        end

        function forward_pass_with_control(haptic_setup)

            error('It is not recommended to forward_pass_with_control() in INIT state.')

        end

        function backward_pass_with_control(haptic_setup)

            error('It is not recommended to backward_pass_with_control() in INIT state.')

        end

        function forward_pass(haptic_setup)

            error('It is not recommended to forward_pass() in INIT state.')

        end

        function backward_pass(haptic_setup)

            error('It is not recommended to backward_pass() in INIT state.')

        end

        function finger_relaxation(haptic_setup)

            error('It is not recommended to finger_relaxation() in INIT state.')

        end

        function control(haptic_setup)

            error('It is not recommended to control() in INIT state.')

        end

    end

end

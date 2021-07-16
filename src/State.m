classdef (Abstract) State < handle
	
	methods (Abstract) 

		start(haptic_setup)
		stop(haptic_setup)
		kill(haptic_setup)
		forward_pass_continuous(haptic_setup)
		backward_pass_continuous(haptic_setup)
		forward_pass(haptic_setup)
		backward_pass(haptic_setup)
		finger_relaxation(haptic_setup)
		control(haptic_setup)

	end


end
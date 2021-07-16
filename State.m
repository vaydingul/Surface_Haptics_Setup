classdef (Abstract) State < handle
	
	methods (Abstract) 

		start(obj, haptic_setup)
		stop(obj, haptic_setup)
		kill(obj, haptic_setup)
		forward_pass_with_control(obj, haptic_setup)
		backward_pass_with_control(obj, haptic_setup)
		forward_pass(obj, haptic_setup)
		backward_pass(obj, haptic_setup)
		finger_relaxation(obj, haptic_setup)
		control(obj, haptic_setup)

	end


end
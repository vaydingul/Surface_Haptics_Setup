classdef (Abstract) State < handle
	
	methods (Abstract) 

<<<<<<< HEAD:src/State.m
		start(haptic_setup)
		stop(haptic_setup)
		kill(haptic_setup)
		forward_pass_continuous(haptic_setup)
		backward_pass_continuous(haptic_setup)
		forward_pass(haptic_setup)
		backward_pass(haptic_setup)
		finger_relaxation(haptic_setup)
		control(haptic_setup)
=======
		start(obj, haptic_setup)
		stop(obj, haptic_setup)
		kill(obj, haptic_setup)
		forward_pass_with_control(obj, haptic_setup)
		backward_pass_with_control(obj, haptic_setup)
		forward_pass(obj, haptic_setup)
		backward_pass(obj, haptic_setup)
		finger_relaxation(obj, haptic_setup)
		control(obj, haptic_setup)
>>>>>>> 336e1172863d051cfdb3f574fff505dddbf7530e:State.m

	end


end
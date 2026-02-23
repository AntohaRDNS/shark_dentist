class_name Helpers
extends Node


static func compare_floats(a: float, b: float, epsilon: float = 0.000001) -> bool:
	return abs(a - b) < epsilon

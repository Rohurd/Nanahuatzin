extends Node

var registry = {}

func register(name, obj):
	registry[name] = obj

func get(name):
	return registry[name]
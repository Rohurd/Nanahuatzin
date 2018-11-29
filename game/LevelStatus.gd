extends Node

var enemies_present = 0
var players_living = 0
var max_enemies = 0
var paused = true
var world = null
var camera = null

var player = null
var ship_controller = null
var ship = null
var difficulty = 0
var enemy_level = 0

var players = []
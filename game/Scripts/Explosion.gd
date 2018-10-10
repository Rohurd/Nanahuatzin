extends Node2D
	
func play():
	$AnimationPlayer.play("Fade")
	$Particles2D.restart()
	show()
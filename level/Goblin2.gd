extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(int) var damage = 10
export var velocity = Vector2()
export(int) var speed = 300
export(float) var smoothness = 0.1
export var direction = 1
onready var sprite = get_node("Goblin2")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)


func _on_Area2D_body_enter( body ):
	if(body.is_in_group("hero")):		
		body.getDamage(damage)
		queue_free()


func _fixed_process(delta):	
	if(is_colliding()):
		direction = direction * (-1)
		
	velocity.y = lerp(velocity.y, speed * direction, smoothness)
	var motion = velocity * delta
	move(motion)
	
	
	
	
	
	
	
	
	
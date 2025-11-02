extends Node2D

@onready var FRTarget: Node2D = $FRTarget;
@onready var FLTarget: Node2D = $FLTarget;
@onready var BLTarget: Node2D = $BLTarget;
@onready var BRTarget: Node2D = $BRTarget;

@export var MAX_K_DISTANCE = 50.0;

var BROffset: Vector2;
var BLOffset: Vector2;
var FLOffset: Vector2;
var FROffset: Vector2;
var BROffset2: Vector2;
var BLOffset2: Vector2;
var FLOffset2: Vector2;
var FROffset2: Vector2;
var rot: float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BROffset = BRTarget.global_position;
	BLOffset = BLTarget.global_position;
	FLOffset = FLTarget.global_position;
	FROffset = FRTarget.global_position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rot = get_parent().rotation;

	# update targets

	if FRTarget.global_position.distance_to(global_position+FROffset.rotated(rot)) > MAX_K_DISTANCE:
		FROffset2 = (FROffset).rotated(rot)+global_position + Vector2(0,-30).rotated(rot);

	if FLTarget.global_position.distance_to(global_position+FLOffset.rotated(rot)) > MAX_K_DISTANCE:
		FLOffset2 = (FLOffset).rotated(rot)+global_position + Vector2(0,-30).rotated(rot);

	if BLTarget.global_position.distance_to(global_position+BLOffset.rotated(rot)) > MAX_K_DISTANCE:
		BLOffset2 = (BLOffset).rotated(rot)+global_position + Vector2(0,-30).rotated(rot);
		
	if BRTarget.global_position.distance_to(global_position+BROffset.rotated(rot)) > MAX_K_DISTANCE:
		BROffset2 = (BROffset).rotated(rot)+global_position + Vector2(0,-30).rotated(rot);
	
	FRTarget.global_position = FRTarget.global_position.lerp(FROffset2, .25);
	FLTarget.global_position = FLTarget.global_position.lerp(FLOffset2, .25);
	BRTarget.global_position = BRTarget.global_position.lerp(BROffset2, .25);
	BLTarget.global_position = BLTarget.global_position.lerp(BLOffset2, .25);

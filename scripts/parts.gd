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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BROffset = BRTarget.global_position;
	BLOffset = BLTarget.global_position;
	FLOffset = FLTarget.global_position;
	FROffset = FRTarget.global_position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# update targets

	if FRTarget.global_position.distance_to(global_position+FROffset) > MAX_K_DISTANCE:
		var dir_vec = (global_position+FROffset) - FRTarget.global_position;
		
		print(dir_vec);

		FROffset2 = global_position+FROffset + dir_vec/2;

	if FLTarget.global_position.distance_to(global_position+FLOffset) > MAX_K_DISTANCE:
		var dir_vec = (global_position+FLOffset) - FLTarget.global_position;
		
		print(dir_vec);

		FLOffset2 = global_position+FLOffset + dir_vec/2;

	if BLTarget.global_position.distance_to(global_position+BLOffset) > MAX_K_DISTANCE:
		var dir_vec = (global_position+BLOffset) - BLTarget.global_position;
		
		print(dir_vec);

		BLOffset2 = global_position+BLOffset + dir_vec/2;
		
	if BRTarget.global_position.distance_to(global_position+BROffset) > MAX_K_DISTANCE:
		var dir_vec = (global_position+BROffset) - BRTarget.global_position;
		
		print(dir_vec);

		BROffset2 = global_position+BROffset + dir_vec/2;

	FRTarget.global_position.lerp(FROffset2, .5);
	FLTarget.global_position.lerp(FLOffset2, .5);
	BRTarget.global_position.lerp(BROffset2, .5);
	BLTarget.global_position.lerp(BLOffset2, .5);

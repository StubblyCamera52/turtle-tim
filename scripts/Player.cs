using System;

namespace TurtleTim.scripts;
using Godot;

public partial class Player : CharacterBody2D
{
	private const float Speed = 1.0f;
	private Vector2 _facingDirection;
	private Label _debug;

  public override void _Ready()
  {
	  _debug = GetNode<Label>(new NodePath("Debug"));
		base._Ready();
		// facing right
		_facingDirection = new Vector2(1, 0);
		_debug.Text = "Ready";
  }
  

	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		if (direction != Vector2.Zero)
		{
			_facingDirection = direction.Normalized();
		}
		if (Input.IsActionPressed("ui_dash"))
		{
			direction = direction.Normalized();
			direction = new Vector2((Math.Sign(direction.X) * _facingDirection.X) + direction.X, (Math.Sign(direction.Y) * direction.Y) + _facingDirection.Y);
		}
		if (direction != Vector2.Zero) {
			velocity.X = direction.X * Speed;
			velocity.Y = direction.Y * Speed;
		}
		else {
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
			velocity.Y = Mathf.MoveToward(Velocity.Y, 0, Speed);
		}

		_debug.Text = $"Veldocity: {velocity}\nDirection: {direction}\nFacing: {_facingDirection}";
        Velocity = velocity;
		MoveAndSlide();
	}
}

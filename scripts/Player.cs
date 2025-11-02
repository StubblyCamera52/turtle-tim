using System;

namespace TurtleTim.scripts;
using Godot;

public partial class Player : CharacterBody2D
{
	private const float Speed = 500.0f;
	private const int MaxStamina = 5;
	private const float StaminaRegenDelay = 1.0f;
	private const float StaminaRegenRate = 0.25f;
	
	private Vector2 _facingDirection;
	private Label _debug;
	private Button _damageButton;
	private int _health = 5;
	private int _stamina = 5;
	private float _timeSinceLastDash = 0f;
	private bool _dashing = false;
	private float _staminaRegenTimer = 0f;
  public override void _Ready()
  {
	  _debug = GetNode<Label>(new NodePath("../Debug"));
	  _damageButton = GetNode<Button>(new NodePath("../Damage"));
		base._Ready();
		_facingDirection = new Vector2(1, 0);
		_debug.Text = "Ready";
		
		_damageButton.Pressed += () =>
		{
			Damage(1);
		};
  }

  private bool Damage(int d)
  {
	  if (_health <= 0) return false;
	  _health -= d;
	  return _health > 0;
  }

  public override void _PhysicsProcess(double delta)
  {
	  GD.Print($"T {_timeSinceLastDash} D {_dashing} DELTA {delta} STAMINA {_stamina}");
		_damageButton.Text = $"Damage: {_health}";
		Vector2 velocity = Velocity;

		_timeSinceLastDash += (float)delta;
		
		if (_timeSinceLastDash > 0.25f && _dashing)
		{
			_dashing = false;
		}
		// GD.Print(_timeSinceLastDash);
		
		if (_timeSinceLastDash >= StaminaRegenDelay && _stamina < MaxStamina)
		{
			_staminaRegenTimer += (float)delta;
			if (_staminaRegenTimer >= 1.0f / StaminaRegenRate)
			{
				_stamina++;
				_staminaRegenTimer = 0f;
			}
		}

		Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		if (direction != Vector2.Zero)
		{
			_facingDirection = direction.Normalized();
			RotationDegrees = Utils.CalculateRotation(_facingDirection);
		}
		
		if ((Input.IsActionJustPressed("ui_dash") && _stamina > 0) | _dashing)
		{
			direction = direction.Normalized();
			direction = Utils.AddVector2(direction, Utils.MultiplyVector2(_facingDirection, 1.5f));
			if (!_dashing)
			{
				_stamina--;
				_timeSinceLastDash = 0f;
				_staminaRegenTimer = 0f;
				_dashing = true;
			}
		}
		
		if (direction != Vector2.Zero) {
			velocity.X = direction.X * Speed;
			velocity.Y = direction.Y * Speed;
		}
		else {
			velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
			velocity.Y = Mathf.MoveToward(Velocity.Y, 0, Speed);
		}
		
		_debug.Text = $"Velocity: {velocity}\nDirection: {direction}\nFacing: {_facingDirection}\nHealth: {_health}\nStamina: {_stamina}/{MaxStamina}";
		Velocity = velocity;
		MoveAndSlide();
	}
}

using System;
using Godot;

namespace TurtleTim.scripts;

internal class Utils
{
    internal static Vector2 AddVector2(Vector2 vector1, Vector2 vector2)
    {
        return new Vector2(vector1.X + vector2.X, vector1.Y + vector2.Y);
    }
}
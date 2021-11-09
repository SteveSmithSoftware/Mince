namespace Mince.Core
{
	public struct Rect
	{
		public Point Position;
		public Size Size;
		public int32 Z=Control.defaultZ;

		public this() {
			Position = Point();
			Size = Size();
		}

		public this(int32 x, int32 y, int32 width, int32 height) {
			Position = Point(x,y);
			Size = Size(width,height);
		}

		public bool Contains(Point p) {
			if (p.X >= Position.X && p.Y >= Position.Y && p.X <= (Position.X+Size.Width) && p.Y <= Position.Y + Size.Height) return true;
			return false;
		}

		public bool Contains(Rect r) {
			if (r.Position.X >= Position.X && r.Position.Y >= Position.Y && r.Position.X+r.Size.Width <= (Position.X+Size.Width) && r.Position.Y+r.Size.Height <= Position.Y + Size.Height)
				 return true;
			return false;
		}
	}
}

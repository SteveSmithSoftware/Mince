namespace Mince.Core
{
	public struct Point
	{
		public int32 X;
		public int32 Y;

		public this() {
			X=0;
			Y=0;
		}

		public this(int32 x, int32 y) {
			X = x;
			Y = y;
		}

		public void Add(Point p) mut {
			X+=p.X;
			Y+=p.Y;
		}
	}
}

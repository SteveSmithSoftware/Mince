namespace Mince.Core
{
	public struct Size
	{
		public int32 Width;
		public int32 Height;

		public this() {
			Width=0;
			Height=0;
		}

		public this(int32 w, int32 h) {
			Width = w;
			Height = h;
		}
	}
}

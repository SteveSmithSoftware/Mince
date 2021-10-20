using System;

namespace Mince.Core
{
	public struct Frame
	{
		public int32 Width;
		public Color Color;

		public this() {
			Width = 2;
			Color = Forms.Theme.panelBorder;
		}

		public void Paint(Graphics g, ref Graphics.Texture texture) {
			if (Width > 0) texture.DrawFrame(g, Color, Width);
		}
	}
}

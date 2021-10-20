using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Text : Control
	{
		public String Text = new String();
		public String FontName = "arial";
		public int32 FontSize = 14;
		public Color FontColor = Theme.text;

		public this(Window window, StringView text, Rect rect) : base(window, rect) {
			text.ToString(Text);
		}
		
		public this(Control parent, StringView text, Rect rect) : base(parent,rect) {
			text.ToString(Text);
		}
		public ~this() {
			delete Text;
		}

		protected override void fillTexture(Rect rect) {
			Graphics g = GetContext();
			texture.FillText(g, Text, FontColor, FontName, FontSize);
			Rect.Size = texture.Rect.Size;
		}
	}
}

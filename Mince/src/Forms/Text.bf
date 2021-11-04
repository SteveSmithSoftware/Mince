using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Text : Control
	{
		public String Text = new String();
		public Font Font ;

		public this(Object parent, Rect rect, StringView text, Font font=null) : base(parent,rect) {
			text.ToString(Text);
			if (font != null) Font = new Font(font);
			else Font = new Font();
		}

		public ~this() {
			delete Text;
			delete Font;
		}

		protected override void fillTexture(Rect rect) {
			Graphics g = GetContext();
			texture.FillText(g, Text, Font);
			Rect.Size = texture.Rect.Size;
		}

		public void SetText(StringView text) {
			if (Text != null) delete Text;
			Text = new String(text);
			IsDirty=true;
		}


	}
}

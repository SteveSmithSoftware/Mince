using System;
using System.Collections;
using Mince.Forms;

namespace Mince.Core
{
	public class Font
	{

		public String Name = "arial";
		public int32 Size = 14;
		public Color Color = Theme.text;

		public this() {
		}

		public this(Font font) {
			Name = font.Name;
			Size = font.Size;
			Color = font.Color;
		}

		public ~this() {
		}

		public void FullName(String fullname) {
			fullname.Append(@"C:\Windows\Fonts\");
			fullname.Append(Name);
			fullname.Append(".ttf");
		}
	}
}

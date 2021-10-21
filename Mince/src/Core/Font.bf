using System;
using Mince.Forms;

namespace Mince.Core
{
	public class Font
	{
		public String Name = "arial";
		public int32 Size = 14;
		public Color Color = Theme.text;

		public void FullName(String fullname) {
			fullname.Append(@"C:\Windows\Fonts\");
			fullname.Append(Name);
			fullname.Append(".ttf");
		}
	}
}

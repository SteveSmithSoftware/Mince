using Mince.Core;
using System;
using System.Collections;

namespace Mince.Forms
{
	public class ListBox : ListView
	{
		Panel selectBox;
		public int32 Selected=0;

		public this(Object parent, Rect rect, List<String> text, Font font) : base(parent,rect,text,font) {
			init(text,font);
		}

		void init(List<String> text, Font font) {
			selectBox = new Panel(this, Rect(0,0,Rect.Size.Width, font.Size+3));
			selectBox.Background.Color = Theme.listSelect;
		}

		public override void Scroll(int32 dir) {
			int32 newPos = selectBox.Rect.Position.Y + (dir * (font.Size+3));
			if (newPos < Rect.Position.Y || newPos > (Rect.Position.Y+Rect.Size.Height)) {
				base.Scroll(dir);
			} else {
				selectBox.Rect.Position.Y += (dir * (font.Size+3));
			}
			Selected += dir;
		}
	}
}

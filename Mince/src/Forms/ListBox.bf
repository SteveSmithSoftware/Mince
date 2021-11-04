using Mince.Core;
using System;
using System.Collections;

namespace Mince.Forms
{
	public class ListBox : ListView
	{
		Panel selectBox;
		public int32 Index=0;
		public StringView SelectedText;

		public System.Event<EventDlg> Selected ~ _.Dispose();

		Event evt = new Event(this) ~ delete _;
		int32 step=0;

		public this(Object parent, Rect rect, List<String> text, Font font=null, int32 selected=0) : base(parent,rect,text,font) {
			init(selected);
		}

		void init(int32 selected) {
			selectBox = new Panel(this, Rect(0,0,Rect.Size.Width, font.Size+3));
			selectBox.Background.Color = Theme.listSelect;
			//SelectedText = lines[selected];
			ScrollTo(selected);
		}

		public override bool KeyDown(KeyEvent event)
		{
			if (event.Code == KeyCode.RETURN && isMouseOver) {
				mousedown=true;
				return true;
			}
			return base.KeyDown(event);
		}

		public override bool KeyUp(KeyEvent event)
		{
			if (mousedown && isMouseOver) {
				Selected(evt);
				mousedown=false;
				return true;
			}
			return base.KeyUp(event);
		}

		public override bool MouseDown(MouseEvent event)
		{
			mousedown = true;
			return true;
		}

		public override bool MouseUp(MouseEvent event)
		{
			if (mousedown) {
				int32 x = event.Position.Y - Rect.Position.Y;
				x /= (font.Size+2);
				if (x != step) {
					Scroll(x-step);
				}
				Selected(evt);
				mousedown=false;
				return true;
			}
			return base.MouseUp(event);
		}

		public override void Scroll(int32 dir) {
			int32 newPos = selectBox.Rect.Position.Y + (dir * (font.Size+2));
			if (newPos < Rect.Position.Y || newPos > (Rect.Position.Y+(Rect.Size.Height-(font.Size+2)))) {
				base.Scroll(dir);
			} else {
				selectBox.Rect.Position.Y = newPos;
				step += dir;
			}
			if (Index+dir >= 0 && Index+dir < lines.Count) {
				Index += dir;
				SelectedText = lines[Index];
			}
		}

		public override int32 ScrollTo(int32 index) {
			if (index != Index) {
				int32 selItem = base.ScrollTo(index);
				int32 offset = index - selItem;
				selectBox.Rect.Position.Y = Rect.Position.Y + (offset * (font.Size+2));
				Index = index;
				SelectedText = lines[index];
			}
			return index;
		}
	}
}

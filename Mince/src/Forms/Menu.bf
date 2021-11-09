using System;
using System.Collections;
using Mince.Core;

namespace Mince.Forms
{
	public class Menu : Panel
	{
		public static int32 menuZ=4;

		public this(Object parent, Rect rect) : base(parent,rect,false,false) {
			Rect.Z = menuZ;
			init();
		}

		void init() {
			Background.Color = Theme.menuBg;
			texture.IsMenu=true;
			if (Parent is MenuItem) {
				((MenuItem)Parent).menu = this;
				isVisible=false;
			}
		}

		public MenuItem Add(StringView text, Rect rect, EventDlg onSelect, Font font=null) {
			IsDirty=true;
			return new MenuItem(this, rect, text, onSelect, font);
		}

		public MenuItem Add(StringView text, Rect rect, Menu menu=null, Font font=null) {
			IsDirty=true;
			return new MenuItem(this, rect, text, menu, font);
		}

		public override void MouseExit(MouseEvent event)
		{
			Graphics g = GetContext();
			g.SetCursor(Theme.Cursor.ARROW);
			if (Parent is MenuItem) isVisible=false;
			base.MouseExit(event);
		}
	}
}

using System;
using System.Collections;
using Mince.Core;

namespace Mince.Forms
{
	public class MenuItem : Button
	{
		public StringView Title;
		public bool Active=true;

		Color highLight;
		public Menu menu;

		public System.Event<EventDlg> Selected ~ _.Dispose();

		Event evt = new Event(this) ~ delete _;

		public this(Menu parent, Rect rect, StringView text, EventDlg onSelect, Font font=null) : base(parent,rect,text) {
			Selected.Add(onSelect);
			init(text);
		}

		public this(Menu parent, Rect rect, StringView text, Menu menu=null, Font font=null) : base(parent,rect,text) {
			if (menu!= null) {
				this.menu = menu;
				children.Add(menu);
				menu.isVisible=false;
			}
			init(text);
		}

		public ~this() {
		}

		void init(StringView text) {
			Title = text;
			Text.Font.Color = Theme.menuText;
			highLight = Theme.menuItemBg;
			Background.Color = ((Menu)Parent).Background.Color;
			texture.IsMenu=true;
			for (Control c in children) {
				c.texture.IsMenu=true;
			}
			hasFrame = false;
		}

		public void Add(Menu menu) {
			this.menu = menu;
			children.Add(menu);
			menu.isVisible=false;
		}

		public override bool KeyUp(KeyEvent event)
		{
			if (mousedown && isMouseOver) {
				OnSelect();
				return true;
			}
			return base.KeyUp(event);
		}

		public override bool MouseUp(MouseEvent event)
		{
			if (mousedown) {
				OnSelect();
				return true;
			}
			return base.MouseUp(event);
		}

		public override void MouseEnter(MouseEvent event)
		{
			Graphics g = GetContext();
			g.SetCursor(Theme.Cursor.HAND);
			Background.Color = highLight;
			IsDirty=true;
			if (menu != null) {
				menu.isVisible=true;
			}
			base.MouseEnter(event);
		}

		public override void MouseExit(MouseEvent event)
		{
			if (menu != null) {
				if (menu.isMouseOver) {
					base.MouseExit(event);
					return;
				}
			}
			Graphics g = GetContext();
			g.SetCursor(Theme.Cursor.ARROW);
			Background.Color = ((Menu)Parent).Background.Color;
			IsDirty=true;
			if (menu != null) {
				menu.isVisible=false;
			}
			base.MouseExit(event);
		}

		void OnSelect() {
			if (menu != null) {
				menu.isVisible=true;
			} else {
				Selected(evt);
			}
			mousedown=false;
		}
	}
}

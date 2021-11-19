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

		public this(Menu parent, Rect rect, StringView text, EventDlg onSelect, Font font=null) : base(parent,rect,text,font) {
			Selected.Add(onSelect);
			init(text);
		}

		public this(Menu parent, Rect rect, StringView text, Menu menu=null, Font font=null) : base(parent,rect,text,font) {
			if (menu != null) {
				this.menu = menu;
				children.Add(menu);
				menu.isVisible=false;
			}
			init(text);
		}

		public ~this() {
		}

		void init(StringView text) {
			Rect.Z = menuZ;
			for (Control c in children) {
				c.Rect.Z = menuZ;
			}

			Title = text;
			Text.Font.Color = Theme.menuText;
			highLight = Theme.menuItemBg;
			Background.Color = ((Menu)Parent).Background.Color;
			hasFrame = false;
			Click.Add(new => OnClick);
		}

		public void Add(Menu menu) {
			this.menu = menu;
			children.Add(menu);
			menu.isVisible=false;
		}

		public override void MouseEnter(MouseEvent event)
		{
			base.MouseEnter(event);
			Background.Color = highLight;
			IsDirty=true;
			if (menu != null) {
				menu.isVisible=true;
			}
		}

		public override void MouseExit(MouseEvent event)
		{
			base.MouseExit(event);
			if (menu != null) {
				if (menu.isMouseOver) {
					base.MouseExit(event);
					return;
				}
			}
			Background.Color = ((Menu)Parent).Background.Color;
			IsDirty=true;
			if (menu != null) {
				menu.isVisible=false;
			}
		}

		void OnClick(MouseEvent event) {
			if (menu != null) {
				menu.isVisible=true;
			} else {
				Selected(evt);
			}
		}
	}
}

using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Button : Panel
	{
		public Text Text;

		public System.Event<MouseDlg> Click ~ _.Dispose();

		MouseEvent evt = new MouseEvent(this) ~ delete _;

		public this(Object parent, Rect rect, StringView text, Font font=null) : base(parent,rect) {
			init(text, font);
		}
		public ~this() {
		}

		void init(StringView txt, Font font) {
			Background.Color = Theme.buttonBg;
			hasFrame = true;
			Frame.Color = Theme.buttonBorder;
			Frame.Width = 1;
			makeText(txt, font);
		}

		void makeText(StringView txt, Font font) {
			if (!txt.IsEmpty) {
				Rect rect = Rect(0,0,Rect.Size.Width,Rect.Size.Height);
				rect.AlignV = .Middle;
				rect.AlignH = .Center;
				Text = new Text(this, rect, txt,font);
				if (font==null) {
					Text.Font.Color = Theme.buttonText;
					Text.Font.Size = 12;
				}
			}
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
				evt.Pressed = .Left;
				Click(evt);
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
				event.Sender = this;
				Click(event);
				mousedown=false;
				return true;
			}
			return base.MouseUp(event);
		}

		public override void MouseEnter(MouseEvent event)
		{
			Graphics g = GetContext();
			g.SetCursor(Theme.Cursor.HAND);
			base.MouseEnter(event);
		}

		public override void MouseExit(MouseEvent event)
		{
			Graphics g = GetContext();
			g.SetCursor(Theme.Cursor.ARROW);
			base.MouseExit(event);
		}

		public void SetText(StringView text,Font font=null) {
			if (Text==null) {
				makeText(text,font);
			} else {
				Text.SetText(text);
			}
		}
	}
}

using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Button : Panel
	{
		public Text Text;

		public System.Event<MouseDlg> Click ~ _.Dispose();

		bool mousedown=false;

		public this(Window window, StringView text, Rect rect) : base(window, rect) {
			init(text);
		}
		
		public this(Control parent, StringView text, Rect rect) : base(parent,rect) {
			init(text);
		}
		public ~this() {
		}

		void init(StringView txt) {
			Background.Color = Theme.buttonBg;
			hasFrame = true;
			Frame.Color = Theme.buttonBorder;
			Frame.Width = 1;
			makeText(txt);
		}

		void makeText(StringView txt) {
			if (!txt.IsEmpty) {
				Rect rect = Rect(0,0,Rect.Size.Width,Rect.Size.Height);
				rect.Position.X = 4;
				rect.Position.Y = 4;
				Text = new Text(this, txt, rect);
				Text.Font.Color = Theme.buttonText;
				Text.Font.Size = 12;
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
				MouseEvent evt = new MouseEvent(this);
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

		public void SetText(StringView text) {
			if (Text==null) {
				makeText(text);
			} else {
				Text.SetText(text);
			}
		}
	}
}

using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Button : Control
	{
		public Panel Panel;
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
			Rect rect = Rect(0,0,Rect.Size.Width,Rect.Size.Height);
			Panel = new Panel(this, rect);
			Panel.Background.Color = Theme.buttonBg;
			Panel.hasFrame = true;
			Panel.Frame.Color = Theme.buttonBorder;
			Panel.Frame.Width = 1;
			rect.Position.X = 4;
			rect.Position.Y = 4;
			if (!txt.IsEmpty) {
				Text = new Text(this, txt, rect);
				Text.FontColor = Theme.buttonText;
				Text.FontSize = 12;
			}
		}
		protected override void fillTexture(Rect rect) {
			//Graphics g = GetContext();
		}

		public override bool KeyDown(KeyEvent event)
		{
			int i=0;
			return base.KeyDown(event);
		}

		public override bool MouseDown(MouseEvent event)
		{
			mousedown = true;
			return true;
		}

		public override bool MouseUp(MouseEvent event)
		{
			if (mousedown) {
				Click(event);
				mousedown=false;
				return true;
			}
			return base.MouseUp(event);
		}
	}
}

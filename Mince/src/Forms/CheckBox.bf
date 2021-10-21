using System;
using Mince.Core;

namespace Mince.Forms
{
	public class CheckBox : Panel
	{
		public bool Checked=false;

		public System.Event<MouseDlg> Click ~ _.Dispose();

		bool mousedown=false;

		public this(Window window, Rect rect) : base(window, rect) {
			init();
		}
		
		public this(Control parent, Rect rect) : base(parent,rect) {
			init();
		}
		public ~this() {
		}

		void init() {
			hasFrame = false;
			/*
			Frame.Color = Color.black;
			Frame.Width = 2;
			*/
			SetChecked();
		}

		void SetChecked() {
			if (Checked) {
				//Background.ImageIx = Theme.ImageIdx.UICheckbox;
				Background.Image = "Tick.bmp";
			} else {
				//Background.ImageIx = Theme.ImageIdx.None;
				Background.Image = "Cross.bmp";
			}
			IsDirty=true;
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
				Checked = !Checked;
				SetChecked();
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
				Checked = !Checked;
				SetChecked();
				Click(event);
				mousedown=false;
				return true;
			}
			return base.MouseUp(event);
		}
	}
}

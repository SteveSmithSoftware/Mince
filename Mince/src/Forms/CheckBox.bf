using System;
using Mince.Core;

namespace Mince.Forms
{
	public class CheckBox : Panel
	{
		public bool Checked=false;

		public System.Event<MouseDlg> Click ~ _.Dispose();
		MouseEvent evt = new MouseEvent(this) ~ delete _;

		public this(Object parent, Rect rect, bool check=false) : base(parent,rect) {
			init(check);
		}

		public ~this() {
		}

		protected void init(bool check) {
			Checked = check;
			hasFrame = false;
			/*
			Frame.Color = Color.black;
			Frame.Width = 2;
			*/
			SetChecked();
		}

		protected virtual void SetChecked() {
			if (Checked) {
				//Background.ImageIx = Theme.ImageIdx.UICheckbox;
				Background.Image = Theme.checkBoxChecked;
			} else {
				//Background.ImageIx = Theme.ImageIdx.None;
				Background.Image = Theme.checkBox;
			}
			IsDirty=true;
		}

		public void SetChecked(bool check) {
			Checked = check;
			SetChecked();
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
	}
}

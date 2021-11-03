using System;
using Mince.Core;

namespace Mince.Forms
{
	public class TextBox : Panel
	{
		public Text Text;

		public System.Event<TextDlg> Changed ~ _.Dispose();

		MouseEvent evt = new MouseEvent(this) ~ delete _;
		TextEvent tEvt = new TextEvent(this) ~ delete _;

		bool hasInput =false;
		String currTxt;

		public this(Object parent, Rect rect, StringView text) : base(parent,rect) {
			init(text);
		}

		public ~this() {
			if (currTxt != null) delete currTxt;
		}

		void init(StringView txt) {
			Background.Color = Theme.buttonBg;
			hasFrame = true;
			Frame.Color = Theme.buttonBorder;
			Frame.Width = 1;
			makeText(txt);
			currTxt = new String(txt);
			tEvt.Text = currTxt;
		}

		void makeText(StringView txt) {
			if (!txt.IsEmpty) {
				Rect rect = Rect(0,0,Rect.Size.Width,Rect.Size.Height);
				rect.Position.X = 4;
				rect.Position.Y = 4;
				Text = new Text(this, rect, txt);
				Text.Font.Color = Theme.buttonText;
				Text.Font.Size = 12;
			}
		}

		public override bool KeyDown(KeyEvent event)
		{
			if (!hasInput) {
				if (event.Code == KeyCode.RETURN && isMouseOver) {
					mousedown=true;
					return true;
				}
			}
			return base.KeyDown(event);
		}

		public override bool KeyUp(KeyEvent event)
		{
			if (!hasInput) {
				if (mousedown && isMouseOver) {
					evt.Pressed = .Left;
					mousedown=false;
					return true;
				}
			} else return TextInput(event);
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
				Graphics g = GetContext();
				g.SetCursor(Theme.Cursor.IBEAM);
				mousedown=false;
				hasInput=true;
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
			if (hasInput) {
				hasInput=false;
				tEvt.Text = currTxt;
				Changed(tEvt);
			}
			base.MouseExit(event);
		}

		public bool TextInput(KeyEvent event) {
			// TODO handle keys correctly
			switch (event.Code) {
			case KeyCode.ESCAPE,
				 KeyCode.TAB,
				 KeyCode.RETURN:
				Graphics g = GetContext();
				g.SetCursor(Theme.Cursor.ARROW);
				hasInput=false;
				tEvt.Text = currTxt;
				Changed(tEvt);
				break;
			case KeyCode.BACKSPACE:
				currTxt.RemoveFromEnd(1);
				SetText(currTxt);
				break;
			default:
				currTxt.Append(event.Char);
				SetText(currTxt);
				break;
			}
			return true;
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

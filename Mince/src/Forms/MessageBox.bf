using System;
using Mince.Core;

namespace Mince.Forms
{
	public class MessageBox : Dialog
	{
		Text message;
		Button ok;

		public System.Event<MouseDlg> OnOK ~ _.Dispose();

		MouseEvent evt = new MouseEvent(this) ~ delete _;

		public this(Object parent, StringView title, Size size, StringView text, Font font=null) : base (parent,title, size, font) {
			init(text, font);
		}

		void init(StringView text, Font font) {
			Rect r = Rect();
			r.AlignH = .Center;
			r.AlignV = .Middle;
			message = new Text(form, r, text, font);

			r.Position.Y = form.Rect.Size.Height - 50;
			r.Size.Width = 50;
			r.Size.Height = 30;
			r.AlignV = .None;
			ok = new Button(form, r, "OK", null);
			ok.Click.Add(new => OKClick);
		}

		public void OKClick(MouseEvent event) {
			isVisible=false;
			OnOK(evt);
		}

		public void SetText(StringView text) {
			message.SetText(text);
		}
	}
}

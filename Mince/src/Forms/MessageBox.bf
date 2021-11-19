using System;
using Mince.Core;

namespace Mince.Forms
{
	public class MessageBox : Control
	{
		Panel header;
		Text title;
		Panel form;
		Text message;
		Button ok;

		public System.Event<MouseDlg> OnOK ~ _.Dispose();

		MouseEvent evt = new MouseEvent(this) ~ delete _;

		public this(Object parent, StringView title, Size size, StringView text, Font font=null) : base (parent, Rect(0,0,size.Width, size.Height)) {
			init(title, text, font);
		}

		void init(StringView heading, StringView text, Font font) {
			isVisible = false;

			header = new Panel(this, Rect(0,0,Rect.Size.Width,30));
			header.Background.Color=Theme.formBg;
			header.hasFrame=true;

			title = new Text(header, Rect(5,0,header.Rect.Size.Width, header.Rect.Size.Height),heading);
			title.Rect.AlignV = .Middle;

			form = new Panel(this, Rect(0,30,Rect.Size.Width, Rect.Size.Height-30));
			form.Background.Color=Theme.formBg;
			form.hasFrame=true;

			Rect r = Rect();
			r.AlignH = .Center;
			r.AlignV = .Middle;
			message = new Text(form, r, text, font);


			r.Position.X = form.Rect.Size.Width - 70;
			r.Position.Y = form.Rect.Size.Height - 50;
			r.Size.Width = 50;
			r.Size.Height = 30;
			ok = new Button(form, r, "OK", null);
			ok.Click.Add(new => OKClick);

			SetZ(3);
		}

		public void Show(Point position) {
			MoveTo(position);
			isVisible=true;
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

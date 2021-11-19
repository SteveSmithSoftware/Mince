using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Dialog : Control
	{
		Panel header;
		protected Text title;
		protected Panel form;

		public System.Event<EventDlg> Close ~ _.Dispose();

		Event evt = new Event(this) ~ delete _;

		public this(Object parent, StringView title, Size size, Font font=null) : base (parent, Rect(0,0,size.Width, size.Height)) {
			init(title, font);
		}

		void init(StringView heading, Font font) {
			isVisible = false;

			header = new Panel(this, Rect(0,0,Rect.Size.Width,30));
			header.Background.Color=Theme.formBg;
			header.hasFrame=true;

			title = new Text(header, Rect(5,0,header.Rect.Size.Width, header.Rect.Size.Height),heading);
			title.Rect.AlignV = .Middle;

			form = new Panel(this, Rect(0,30,Rect.Size.Width, Rect.Size.Height-30));
			form.Background.Color=Theme.formBg;
			form.hasFrame=true;

			SetZ(3);
		}

		public void Show(Point position) {
			MoveTo(position);
			isVisible=true;
		}
	}
}

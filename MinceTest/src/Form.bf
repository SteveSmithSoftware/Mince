using System;
using Mince.Forms;
using Mince.Core;

namespace MinceTest
{
	class Form : Window
	{
		Text text;
		Button button;
		CheckBox checkbox;

		public this(StringView title) :base(title, Size(800,640))
		{
			text = new Text(StatusBar, "Hello World", Rect(5,5,0,0));
			button = new Button(Form, "Press Me", Rect(5,5,100,20));
			button.Click.Add( new =>  this.ButtonClick);
			checkbox = new CheckBox(Form, Rect(5,30,20,20));

			Run();
		}

		public ~this() {
		}

		public void ButtonClick(MouseEvent event) {
			((Button)event.Sender).SetText("Pressed");
			text.SetText("Button Pressed");
		}
	}
}

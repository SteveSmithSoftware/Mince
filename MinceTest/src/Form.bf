using System;
using Mince.Forms;
using Mince.Core;

namespace MinceTest
{
	class Form : Window
	{
		Text text;

		public this(StringView title) :base(title, Size(800,640))
		{
			text = new Text(StatusBar, "Hello World", Rect(5,5,0,0));
			Button button = new Button(Form, "Press Me", Rect(5,5,100,20));
			button.Click.Add( new =>  this.ButtonClick);

			Run();
		}

		public ~this() {
		}

		public void ButtonClick(MouseEvent event) {
			delete text.Text;
			text.Text = new String("Button Pressed");
			text.IsDirty=true;
		}
	}
}

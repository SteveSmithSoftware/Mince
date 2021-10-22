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
		CheckBox checkbox1;
		RadioButton radiobutton;
		RadioButton radiobutton1;
		RadioGroup radiogroup;

		public this(StringView title) :base(title, Size(800,640))
		{
			text = new Text(StatusBar, "Hello World", Rect(5,5,0,0));

			button = new Button(Form, "Press Me", Rect(5,5,100,20));
			button.Click.Add( new =>  this.ButtonClick);

			checkbox = new CheckBox(Form, Rect(5,30,20,20));
			checkbox.Click.Add( new => this.CheckBoxClick);

			checkbox1 = new CheckBox(Form, Rect(30,30,20,20),true);
			checkbox1.Click.Add( new => this.CheckBoxClick);

			radiobutton = new RadioButton(Form, Rect (5,55,20,20),0);
			radiobutton.Click.Add( new => this.RadioClick);

			radiobutton1 = new RadioButton(Form, Rect (30,55,20,20),1, true);
			radiobutton1.Click.Add( new => this.RadioClick);

			radiogroup = new RadioGroup(Form, Rect(5,80, 110, 32), 5);
			radiogroup.Click.Add( new => this.RadioGroupClick);

			Run();
		}

		public ~this() {
		}

		public void ButtonClick(MouseEvent event) {
			((Button)event.Sender).SetText("Pressed");
			text.SetText("Button Pressed");
		}

		public void CheckBoxClick(MouseEvent event) {
			CheckBox cb  = (CheckBox)event.Sender;
			String s = scope String("CheckBox Changed. Value is ");
			s.Append(cb.Checked.ToString(.. scope String()));
			text.SetText(s);
		}

		public void RadioClick(MouseEvent event) {
			RadioButton rb  = (RadioButton)event.Sender;
			String s = scope String("Radio Button ");
			s.Append(rb.Index.ToString(.. scope String()));
			s.Append(" Changed. Value is ");
			s.Append(rb.Checked.ToString(.. scope String()));
			text.SetText(s);
		}

		public void RadioGroupClick(MouseEvent event) {
			RadioButton rb  = (RadioButton)event.Sender;
			String s = scope String("Radio Group Changed. Selected Button is ");
			s.Append(rb.Index.ToString(.. scope String()));
			text.SetText(s);
		}
	}
}

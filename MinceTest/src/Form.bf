using System;
using System.Collections;
using Mince.Forms;
using Mince.Core;

namespace MinceTest
{
	class Form : DesktopWindow
	{
		Text text;
		Button button;
		CheckBox checkbox;
		CheckBox checkbox1;
		RadioButton radiobutton;
		RadioButton radiobutton1;
		RadioGroup radiogroup;
		TextBox textbox;
		ListView listview;
		ListBox listbox;
		DropDown dropdown;

		public this(StringView title) :base(title, Size(800,640))
		{
			text = new Text(StatusBar, Rect(5,5,0,0), "Hello World");

			button = new Button(Form, Rect(5,5,100,20), "Press Me");
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

			textbox = new TextBox(Form, Rect(5,120, 200,20),"");
			textbox.Changed.Add( new => this.TextEntered);

			List<String> l = scope List<String>();
			l.Add("Line 1");
			l.Add("Line 2");
			l.Add("Line 3");
			l.Add("Line 4");
			l.Add("Line 5");
			l.Add("Line 6");
			l.Add("Line 7");
			l.Add("Line 8");
			l.Add("Line 9");
			l.Add("Line 10");
			Font f = scope Font();
			f.Size = 12;

			listview = new ListView(Form, Rect(5,150, 200, 100),l, f,0);

			listbox = new ListBox(Form, Rect(250,150, 200, 100),l,f,0);
			listbox.Selected.Add( new => this.ListSelected);

			dropdown = new DropDown(Form, Rect(5,270,200,20),l,f,2,5);
			dropdown.Selected.Add( new => this.DropDownSelected);

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

		public void TextEntered(TextEvent event) {
			String s = scope String("Text Changed to ");
			s.Append(event.Text);
			text.SetText(s);

		}

		public void ListSelected(Event event) {
			ListBox lb  = (ListBox)event.Sender;
			String s = scope String("List Item ");
			s.Append(lb.Index.ToString(.. scope String()));
			s.Append(" selected. Item text: ");
			s.Append(lb.SelectedText);
			text.SetText(s);
		}

		public void DropDownSelected(Event event) {
			DropDown dd  = (DropDown)event.Sender;
			String s = scope String("Dropdown Item ");
			s.Append(dd.Index.ToString(.. scope String()));
			s.Append(" selected. Item text: ");
			s.Append(dd.SelectedText);
			text.SetText(s);
		}
	}
}

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
		Menu menu;

		public this(StringView title) :base(title, Size(800,640))
		{
			menu = new Menu(ToolStrip, Rect(4,2,ToolStrip.Rect.Size.Width-8, 20));
			MenuItem file = menu.Add("File",Rect(0,0,50,20));
			Menu fileMenu = new Menu(file, Rect(0,20,80,140));
			fileMenu.Add("New", Rect(0,5,50,20),new => this.MenuItemSelected);
			fileMenu.Add("Open", Rect(0,30,50,20),new => this.MenuItemSelected);
			fileMenu.Add("Save", Rect(0,60,50,20),new => this.MenuItemSelected);
			fileMenu.Add("Save As", Rect(0,90,50,20),new => this.MenuItemSelected);
			fileMenu.Add("Exit", Rect(0,120,50,20),new => this.MenuItemSelected);

			menu.Add("Edit",Rect(50,0,50,20),new => this.MenuItemSelected);
			menu.Add("View",Rect(100,0,50,20),new => this.MenuItemSelected);
			menu.Add("Tools",Rect(150,0,50,20),new => this.MenuItemSelected);
			menu.Add("About",Rect(200,0,50,20),new => this.MenuItemSelected);
			menu.Add("Help",Rect(250,0,50,20),new => this.MenuItemSelected);

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

		public void MenuItemSelected(Event event) {
			MenuItem mi = (MenuItem)event.Sender;
			String s = scope String("Menu Item ");
			s.Append(mi.Title);
			s.Append(" selected");
			text.SetText(s);
		}
	}
}

using System;
using Mince.Core;

namespace Mince.Forms
{
	class RadioGroup : Panel
	{

		public int32 Count;
		public RadioButton[] buttons;

		public System.Event<MouseDlg> Click ~ _.Dispose();

		public this(Object parent, Rect rect,int32 count) : base(parent,rect) {
			init(count);
		}

		public ~this() {
			delete buttons;
		}

		void init(int32 count) {
			Count = count;
			buttons = new RadioButton[count];

			Background.Color = Theme.buttonBg;
			hasFrame=true;
			Frame.Color = Theme.buttonBorder;
			Frame.Width = 1;


			int32 x=4;
			int32 y = 8;
			int32 h=Rect.Size.Height-16;
			int32 w = h; // ((Rect.Size.Width-8) / count)-5;
			for (int32 i=0;i<count;i++) {
				buttons[i] = new RadioButton(this, Rect(x,y,w,h), i);
				x += w+5;
				buttons[i].Click.Add( new =>  this.ButtonClick);
			}
		}

		public void ButtonClick(MouseEvent event) {
			RadioButton rb = (RadioButton)event.Sender;
			for (int32 i=0;i<Count;i++) {
				if (i == rb.Index) {
					if (!buttons[i].Checked) buttons[i].SetChecked(true);
				}
				else if (buttons[i].Checked) buttons[i].SetChecked(false);
			}
			Click(event);
		}
	}
}

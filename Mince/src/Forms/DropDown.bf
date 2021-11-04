using System;
using System.Collections;
using Mince.Core;

namespace Mince.Forms
{
	public class DropDown : Panel
	{
		Text text;
		Button button;
		ListBox listBox;

		public int32 Index=0;
		public StringView SelectedText;

		public System.Event<EventDlg> Selected ~ _.Dispose();

		Event evt = new Event(this) ~ delete _;

		public this(Object parent, Rect rect, List<String> text, Font font=null, int32 selected=0 ,int32 maxItems=10) : base(parent,rect) {
			int32 i = selected;
			if (i < 0 || i > text.Count) i = 0;
			int32 m = maxItems;
			if (m < 0 || m > text.Count) m=(int32)text.Count;
			init(text,font, i, m);
		}

		void init( List<String> lines, Font font, int32 selected, int32 maxItems) {
			Background.Color = Theme.dropDownBg;
			hasFrame=false;

			text = new Text(this, Rect(0,2,Rect.Size.Width-Rect.Size.Height, Rect.Size.Height),lines[selected],font);

			button = new Button(this, Rect(Rect.Size.Width-Rect.Size.Height,0,Rect.Size.Height,Rect.Size.Height),"");
			button.Background.ImageIx = Theme.ImageIdx.VertScrollbarArrow;
			button.Click.Add( new =>  this.ButtonClick);

			listBox = new ListBox(this,Rect(0,Rect.Size.Height,Rect.Size.Width,maxItems * (text.Font.Size+2)),lines,font,selected);
			listBox.isVisible = false;
			listBox.Selected.Add( new => this.ListSelected);

			Index = selected;
			SelectedText = lines[selected];
		}

		public void ButtonClick(MouseEvent event) {
			listBox.isVisible = !listBox.isVisible;
		}

		public void ListSelected(Event event) {
			ListBox lb  = (ListBox)event.Sender;
			Index = lb.Index;
			SelectedText = lb.SelectedText;
			text.SetText(SelectedText);
			listBox.isVisible=false;
			Selected(evt);
		}
	}
}

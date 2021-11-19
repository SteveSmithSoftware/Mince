using System;
using Mince.Core;

namespace Mince.Forms
{
	public class ScrollBarVert : Control
	{
		public Panel Bar;
		public Button Thumb;
		public Button UpArrow;
		public Button DownArrow;

		public System.Event<ScrollDlg> Scroll ~ _.Dispose();

		ScrollEvent evt = new ScrollEvent(this) ~ delete _;

		public this(Object parent, Rect rect) : base(parent,rect) {
			init();
		}

		void init() {
			UpArrow = new Button(this, Rect(0,0,Rect.Size.Width, Rect.Size.Width),"");
			UpArrow.hasFrame=false;
			UpArrow.Background.ImageIx = Theme.ImageIdx.VertScrollbarArrow;
			UpArrow.texture.Rotate=true;
			UpArrow.Click.Add( new =>  this.UpClick);

			DownArrow = new Button(this, Rect(0,Rect.Size.Height-Rect.Size.Width,Rect.Size.Width, Rect.Size.Width),"");
			DownArrow.hasFrame=false;
			DownArrow.Background.ImageIx = Theme.ImageIdx.VertScrollbarArrow;
			DownArrow.Click.Add( new =>  this.DownClick);

			Bar = new Panel(this, Rect(0, Rect.Size.Width, Rect.Size.Width, Rect.Size.Height-(Rect.Size.Width*2)));
			Bar.Background.Color = Theme.scrollBg;

			Thumb = new Button(Bar, Rect(0, 0 ,Rect.Size.Width, Rect.Size.Width*2),"");
			Thumb.hasFrame=false;
			Thumb.Background.Color = Theme.scrollThumb;
		}

		public override bool MouseScroll(MouseEvent event) {
			if (event.Delta.Y<0) DownClick(event); else UpClick(event);
			return true;
		}

		public void UpClick(MouseEvent event) {
			evt.Dir = -1;
			Scroll(evt);
		}
		public void DownClick(MouseEvent event) {
			evt.Dir=1;
			Scroll(evt);
		}
	}
}

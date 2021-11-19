using System;
using Mince.Core;

namespace Mince.Forms
{
	public class ScrollBarHoriz : Control
	{
		public Panel Bar;
		public Button Thumb;
		public Button LeftArrow;
		public Button RightArrow;

		public System.Event<ScrollDlg> Scroll ~ _.Dispose();

		ScrollEvent evt = new ScrollEvent(this) ~ delete _;

		public this(Object parent, Rect rect) : base(parent,rect) {
			init();
		}

		void init() {
			LeftArrow = new Button(this, Rect(0,0,Rect.Size.Height, Rect.Size.Height), "");
			LeftArrow.hasFrame=false;
			LeftArrow.Background.ImageIx = Theme.ImageIdx.ScrollbarArrow;
			LeftArrow.texture.Rotate=true;
			LeftArrow.Click.Add( new =>  this.LeftClick);


			RightArrow = new Button(this, Rect(Rect.Size.Width-Rect.Size.Height,0,Rect.Size.Height, Rect.Size.Height), "");
			RightArrow.hasFrame=false;
			RightArrow.Background.ImageIx = Theme.ImageIdx.ScrollbarArrow;
			RightArrow.Click.Add( new =>  this.RightClick);


			Bar = new Panel(this, Rect(Rect.Size.Height, 0, Rect.Size.Width- (Rect.Size.Height*2), Rect.Size.Height));
			Bar.Background.Color = Theme.scrollBg;

			Thumb = new Button(Bar, Rect(0, 0 ,Rect.Size.Height*2, Rect.Size.Height), "");
			Thumb.hasFrame=false;
			Thumb.Background.Color = Theme.scrollThumb;
		}

		public override bool MouseScroll(MouseEvent event) {
			if (event.Delta.Y<0) RightClick(event); else LeftClick(event);
			return true;
		}

		public void LeftClick(MouseEvent event) {
			evt.Dir = -1;
			Scroll(evt);
		}
		public void RightClick(MouseEvent event) {
			evt.Dir=1;
			Scroll(evt);
		}
	}
}

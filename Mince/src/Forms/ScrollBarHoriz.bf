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

		public this(Window window, Rect rect) : base(window, rect) {
			init();
		}
		
		public this(Control parent, Rect rect) : base(parent,rect) {
			init();
		}

		void init() {
			LeftArrow = new Button(this, "", Rect(0,0,Rect.Size.Height, Rect.Size.Height));
			LeftArrow.hasFrame=false;
			LeftArrow.Background.ImageIx = Theme.ImageIdx.ScrollbarArrow;
			LeftArrow.texture.Rotate=true;

			RightArrow = new Button(this, "", Rect(Rect.Size.Width-Rect.Size.Height,0,Rect.Size.Height, Rect.Size.Height));
			RightArrow.hasFrame=false;
			RightArrow.Background.ImageIx = Theme.ImageIdx.ScrollbarArrow;

			Bar = new Panel(this, Rect(Rect.Size.Height, 0, Rect.Size.Width- (Rect.Size.Height*2), Rect.Size.Height));
			Bar.Background.Color = Theme.scrollBg;

			Thumb = new Button(Bar, "", Rect(0, 0 ,Rect.Size.Height*2, Rect.Size.Height));
			Thumb.hasFrame=false;
			Thumb.Background.Color = Theme.scrollThumb;
		}

		protected override void fillTexture(Rect rect) {
			//Graphics g = GetContext();
		}
	}
}

using System;
using Mince.Core;

namespace Mince.Forms
{
	public class Panel : Control
	{
		public Background Background;
		public Frame Frame;

		public bool hasFrame=false;
		public bool hasHorizScrollBar = false;
		public bool hasVertScrollBar = false;

		public ScrollBarHoriz HorizScrollBar;
		public ScrollBarVert VertScrollBar;

		int32 scrollWidth = 15;

		
		public this(Object parent, Rect rect, bool scrollHoriz=false, bool scrollVert=false) : base(parent,rect) {
			hasHorizScrollBar = scrollHoriz;
			hasVertScrollBar = scrollVert;
			init();
		}

		void init() {
			Background = Background();
			Frame = Frame();
			if (hasHorizScrollBar) {
				int32 offset = 0;
				if (hasVertScrollBar) offset=scrollWidth;
				HorizScrollBar = new ScrollBarHoriz(this, Rect(0, Rect.Size.Height-scrollWidth, Rect.Size.Width-offset, scrollWidth));
			}
			if (hasVertScrollBar) {
				int32 offset = 0;
				if (hasHorizScrollBar) offset=scrollWidth;
				VertScrollBar = new ScrollBarVert(this, Rect(Rect.Size.Width-scrollWidth, 0, scrollWidth, Rect.Size.Height-offset));
				VertScrollBar.Scroll.Add( new =>  this.Scroll);
			}
			if (hasHorizScrollBar) Rect.Size.Height -=scrollWidth;
			if (hasVertScrollBar) Rect.Size.Width-=scrollWidth;
		}

		protected override void fillTexture(Rect rect) {
			Graphics g = GetContext();
			Background.Paint(g, ref texture);
			if (hasFrame) Frame.Paint(g, ref texture);
		}

		public virtual void Scroll(ScrollEvent event) {

		}
	}
}

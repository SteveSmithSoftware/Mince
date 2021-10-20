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

		public this(Window window, Rect rect) : base(window, rect) {
			init();
		}
		
		public this(Control parent, Rect rect) : base(parent,rect) {
			init();
		}

		void init() {
			UpArrow = new Button(this, "", Rect(0,0,Rect.Size.Width, Rect.Size.Width));
			UpArrow.Panel.hasFrame=false;
			UpArrow.Panel.Background.ImageIx = Theme.ImageIdx.VertScrollbarArrow;
			UpArrow.Panel.texture.Rotate=true;

			DownArrow = new Button(this, "", Rect(0,Rect.Size.Height-Rect.Size.Width,Rect.Size.Width, Rect.Size.Width));
			DownArrow.Panel.hasFrame=false;
			DownArrow.Panel.Background.ImageIx = Theme.ImageIdx.VertScrollbarArrow;

			Bar = new Panel(this, Rect(0, Rect.Size.Width, Rect.Size.Width, Rect.Size.Height-(Rect.Size.Width*2)));
			Bar.Background.Color = Theme.scrollBg;

			Thumb = new Button(Bar, "", Rect(0, 0 ,Rect.Size.Width, Rect.Size.Width*2));
			Thumb.Panel.hasFrame=false;
			Thumb.Panel.Background.Color = Theme.scrollThumb;
		}

		protected override void fillTexture(Rect rect) {
			//Graphics g = GetContext();
		}
	}
}

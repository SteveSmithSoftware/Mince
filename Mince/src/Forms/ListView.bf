using System;
using System.Collections;
using Mince.Core;

namespace Mince.Forms
{
	public class ListView : Panel
	{
		public Font font ~ delete _;
		public List<String> lines ~ DeleteContainerAndItems!(_);
		public int32 count=0;
		public int32 topItem=0;

		public this(Object parent, Rect rect, List<String> text, Font font) : base(parent,rect,false,true) {
			init(text,font);
		}

		void init( List<String> text, Font font) {
			Background.Color = Theme.listBg;
			hasFrame=false;
			lines = new List<String>();
			for (String s in text) {
				lines.Add(new String(s));
			}
			this.font = new Font(font);
			count = Rect.Size.Height / (font.Size +2);
			if (count < lines.Count) VertScrollBar.isVisible = true;
			else VertScrollBar.isVisible = false;
		}

		protected override void fillTexture(Rect rect) {
			base.fillTexture(rect);
			PaintText();
		}

		void PaintText() {
			Graphics g = GetContext();
			Rect r = Rect(0,0,Rect.Size.Width, font.Size);
			if (lines != null && lines.Count>0) {
				texture.AddText(g,lines,font, r, topItem, count);
			}
		}

		public override bool MouseScroll(MouseEvent event) {
			Scroll(event.Delta.Y*-1);
			return true;
		}

		public override void Scroll(ScrollEvent event) {
			Scroll(event.Dir);
		}

		public virtual void Scroll(int32 dir) {
			int32 selItem = topItem+dir;
			if (selItem<0 || selItem+count>lines.Count) return;
			topItem = selItem;
			IsDirty=true;
		}
	}
}

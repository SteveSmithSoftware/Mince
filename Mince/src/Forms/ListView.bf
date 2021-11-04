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

		public this(Object parent, Rect rect, List<String> text, Font font=null, int32 start=0) : base(parent,rect,false,true) {
			if (font != null) this.font = new Font(font);
			else this.font = new Font();
			init(text,start);
		}

		void init( List<String> text, int32 start) {
			Background.Color = Theme.listBg;
			hasFrame=false;
			lines = new List<String>();
			for (String s in text) {
				lines.Add(new String(s));
			}
			count = Rect.Size.Height / (font.Size +2);
			if (count < lines.Count) VertScrollBar.isVisible = true;
			else VertScrollBar.isVisible = false;
			ScrollTo(start);
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

		public virtual int32 ScrollTo(int32 index) {
			int32 selItem = index;
			if (selItem != topItem) {
				if (selItem<0) selItem=0;
				else if (selItem+count>lines.Count) selItem = (int32)lines.Count-count;
				topItem = selItem;
				IsDirty=true;
			}
			return topItem;
		}
	}
}

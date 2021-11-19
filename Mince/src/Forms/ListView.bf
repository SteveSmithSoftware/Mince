using System;
using System.Collections;
using Mince.Core;

namespace Mince.Forms
{
	public class ListView : Panel
	{
		public Font font ~ delete _;
		public List<String> origLines ~ DeleteContainerAndItems!(_);
		public List<StringView> lines ~ DeleteAndNullify!(_);
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
			origLines = new List<String>();
			lines = new List<StringView>();
			for (int i=0; i< text.Count;i++) {
				origLines.Add(new String(text[i]));
				lines.Add(origLines[i]);
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

		public void Contains(StringView text) {
			String s = scope String(text);
			lines.Clear();
			for (int i=0;i<origLines.Count;i++) {
				if (origLines[i].Contains(s)) lines.Add(origLines[i]);
			}
			IsDirty=true;
		}

		public void StartsWith(StringView text) {
			String s = scope String(text);
			lines.Clear();
			for (int i=0;i<origLines.Count;i++) {
				if (origLines[i].StartsWith(s)) lines.Add(origLines[i]);
			}
			IsDirty=true;
		}

		public void Subset(int[] indexes) {
			lines.Clear();
			for (int i=0;i<indexes.Count;i++) {
				if (origLines.Count > indexes[i]) lines.Add(origLines[indexes[i]]);
			}
			IsDirty=true;
		}

		public void Subset(bool[] indexes) {
			if (indexes.Count != origLines.Count) return;
			lines.Clear();
			for (int i=0;i<indexes.Count;i++) {
				if (indexes[i]) lines.Add(origLines[i]);
			}
			IsDirty=true;
		}
	}
}

using System;
using Mince.Core;

namespace Mince.Forms
{
	public class DesktopWindow: Window
	{
		public bool hasToolStrip = true;
		public Panel ToolStrip;
		public Panel Form;
		public bool hasStatusBar = true;
		public Panel StatusBar;

		public this(StringView title, Size size): base(title, size)
		{
			int32 usedH = 0;
			int32 tsH=50;
			if (hasToolStrip) {
				ToolStrip = new Panel(this, Rect(0,0,size.Width,tsH));
				ToolStrip.Background.Color=Theme.toolStripBg;
				ToolStrip.hasFrame=true;
				usedH+=tsH;
			} else tsH=0;

			int32 sbH=30;
			if (hasStatusBar) {
				StatusBar = new Panel(this, Rect(0,size.Height-sbH,size.Width,sbH));
				StatusBar.Background.Color=Theme.statusBarBg;
				StatusBar.hasFrame=true;
				usedH+=sbH;
			} else sbH=0;

			Form = new Panel(this, Rect(0,tsH,size.Width,size.Height-usedH),true,true);
			Form.Background.Color=Theme.formBg;
		}

		public ~this()
		{
			if (ToolStrip != null) DeleteAndNullify!(ToolStrip);
			if (Form != null) DeleteAndNullify!(Form);
			if (StatusBar != null) DeleteAndNullify!(StatusBar);
		}
	}
}

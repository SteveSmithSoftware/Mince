using System;
using Mince.Core;

namespace Mince.Forms
{
	public class RadioButton : CheckBox
	{
		public int32 Index;

		public this(Window window, Rect rect, int32 index, bool check=false) : base(window, rect) {
			Index = index;
			Checked = check;
			base.init(check);
		}
		
		public this(Control parent, Rect rect, int32 index, bool check=false) : base(parent,rect) {
			Index = index;
			Checked = check;
			base.init(check);
		}

		protected override void SetChecked() {
			if (Checked) {
				Background.ImageIx = Theme.radioButtonChecked;
			} else {
				Background.ImageIx = Theme.radioButton;
			}
			IsDirty=true;
		}
	}
}

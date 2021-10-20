using System;

namespace Mince.Core
{
	public class MouseEvent : Event
	{
        public Point Position;
        public Button Pressed;
		public Point Delta;
 		public bool IsDoubleClick;

		public enum Button {
			Left,
			Middle,
			Right,
			X1,
			X2
		}

		public this(Object sender) : base (sender) { }
	}
}

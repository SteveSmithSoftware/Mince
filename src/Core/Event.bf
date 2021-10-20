using System;

namespace Mince.Core
{
	delegate void KeyDlg(KeyEvent event);
	delegate void MouseDlg(MouseEvent event);
	delegate void EventDlg(Event event);

	public class Event
	{
		public enum EventType {
			KeyDown,
			KeyUp,
			MouseDown,
			MouseUp,
			MouseMove,
			MouseScroll,
			Unknown
		}
 		public Object Sender;
        public bool Bubble;
		public EventType Event;

		public this(Object sender)
		{
			this.Sender = sender;
		}
 	}
}

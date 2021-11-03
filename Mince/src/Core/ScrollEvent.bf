using System;

namespace Mince.Core
{
	public class ScrollEvent : Event
	{
		public int32 Dir;

		public this(Object sender) : base (sender) { }
	}
}

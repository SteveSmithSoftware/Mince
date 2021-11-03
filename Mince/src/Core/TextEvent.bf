using System;

namespace Mince.Core
{
	public class TextEvent : Event
	{
		public StringView Text;

		public this(Object sender) : base (sender) { }
	}
}

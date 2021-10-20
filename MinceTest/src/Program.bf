using Mince.Core;
using Mince.Forms;

namespace MinceTest
{
	static class Program
	{
		static Form form;

		static void Main() {
			form = new Form("Test Form");
		}

		static ~this() {
			delete form;
		}
	}
}
				    
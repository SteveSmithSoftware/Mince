using System;
using Mince.Forms;

namespace Mince.Core
{
	public struct Background
	{
		public String Image;
		public Color Color;
		public Theme.ImageIdx ImageIx= Theme.ImageIdx.None;

		char8[] BitMap;

		public void Paint(Graphics g, ref Graphics.Texture texture) {
			if (ImageIx == Theme.ImageIdx.None && Image == null) {
				texture.FillColor(g, Color);
			} else {
				if (ImageIx == Theme.ImageIdx.None) {
					texture.FillImage(g, Image);
				} else {
					texture.FillImage(g, (int32)ImageIx);
				}
			}
		}
	}
}

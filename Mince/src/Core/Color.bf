namespace Mince.Core
{
	public struct Color
	{
		public uint8 R;
		public uint8 G;
		public uint8 B;
		public uint8 A;

		public this()
		{
			R = 0;
			G = 0;
			B = 0;
			A = 0;
		}

		public this(uint8 r, uint8 g, uint8 b, uint8 a)
		{
			R = r;
			G = g;
			B = b;
			A = a;
		}

		public this(uint8 r, uint8 g, uint8 b)
		{
			R = r;
			G = g;
			B = b;
			A = 255;
		}

		public this(Color c)
		{
			R = c.R;
			G = c.G;
			B = c.B;
			A = c.A;
		}

		public static Color white { get { return Color(255, 255, 255); } }
		public static Color maroon { get { return Color(128, 0, 0); } }
		public static Color darkred { get { return Color(139, 0, 0); } }
		public static Color brown { get { return Color(165, 42, 42); } }
		public static Color firebrick { get { return Color(178, 34, 34); } }
		public static Color crimson { get { return Color(220, 20, 60); } }
		public static Color red { get { return Color(255, 0, 0); } }
		public static Color tomato { get { return Color(255, 99, 71); } }
		public static Color coral { get { return Color(255, 127, 80); } }
		public static Color indianred { get { return Color(205, 92, 92); } }
		public static Color lightcoral { get { return Color(240, 128, 128); } }
		public static Color darksalmon { get { return Color(233, 150, 122); } }
		public static Color salmon { get { return Color(250, 128, 114); } }
		public static Color lightsalmon { get { return Color(255, 160, 122); } }
		public static Color orangered { get { return Color(255, 69, 0); } }
		public static Color darkorange { get { return Color(255, 140, 0); } }
		public static Color orange { get { return Color(255, 165, 0); } }
		public static Color gold { get { return Color(255, 215, 0); } }
		public static Color darkgoldenrod { get { return Color(184, 134, 11); } }
		public static Color goldenrod { get { return Color(218, 165, 32); } }
		public static Color palegoldenrod { get { return Color(238, 232, 170); } }
		public static Color darkkhaki { get { return Color(189, 183, 107); } }
		public static Color khaki { get { return Color(240, 230, 140); } }
		public static Color olive { get { return Color(128, 128, 0); } }
		public static Color yellow { get { return Color(255, 255, 0); } }
		public static Color yellowgreen { get { return Color(154, 205, 50); } }
		public static Color darkolivegreen { get { return Color(85, 107, 47); } }
		public static Color olivedrab { get { return Color(107, 142, 35); } }
		public static Color lawngreen { get { return Color(124, 252, 0); } }
		public static Color chartreuse { get { return Color(127, 255, 0); } }
		public static Color greenyellow { get { return Color(173, 255, 47); } }
		public static Color darkgreen { get { return Color(0, 100, 0); } }
		public static Color green { get { return Color(0, 128, 0); } }
		public static Color forestgreen { get { return Color(34, 139, 34); } }
		public static Color lime { get { return Color(0, 255, 0); } }
		public static Color limegreen { get { return Color(50, 205, 50); } }
		public static Color lightgreen { get { return Color(144, 238, 144); } }
		public static Color palegreen { get { return Color(152, 251, 152); } }
		public static Color darkseagreen { get { return Color(143, 188, 143); } }
		public static Color mediumspringgreen { get { return Color(0, 250, 154); } }
		public static Color springgreen { get { return Color(0, 255, 127); } }
		public static Color seagreen { get { return Color(46, 139, 87); } }
		public static Color mediumaquamarine { get { return Color(102, 205, 170); } }
		public static Color mediumseagreen { get { return Color(60, 179, 113); } }
		public static Color lightseagreen { get { return Color(32, 178, 170); } }
		public static Color darkslategray { get { return Color(47, 79, 79); } }
		public static Color teal { get { return Color(0, 128, 128); } }
		public static Color darkcyan { get { return Color(0, 139, 139); } }
		public static Color aqua { get { return Color(0, 255, 255); } }
		public static Color cyan { get { return Color(0, 255, 255); } }
		public static Color lightcyan { get { return Color(224, 255, 255); } }
		public static Color darkturquoise { get { return Color(0, 206, 209); } }
		public static Color turquoise { get { return Color(64, 224, 208); } }
		public static Color mediumturquoise { get { return Color(72, 209, 204); } }
		public static Color paleturquoise { get { return Color(175, 238, 238); } }
		public static Color aquamarine { get { return Color(127, 255, 212); } }
		public static Color powderblue { get { return Color(176, 224, 230); } }
		public static Color cadetblue { get { return Color(95, 158, 160); } }
		public static Color steelblue { get { return Color(70, 130, 180); } }
		public static Color cornflowerblue { get { return Color(100, 149, 237); } }
		public static Color deepskyblue { get { return Color(0, 191, 255); } }
		public static Color dodgerblue { get { return Color(30, 144, 255); } }
		public static Color lightblue { get { return Color(173, 216, 230); } }
		public static Color skyblue { get { return Color(135, 206, 235); } }
		public static Color lightskyblue { get { return Color(135, 206, 250); } }
		public static Color midnightblue { get { return Color(25, 25, 112); } }
		public static Color navy { get { return Color(0, 0, 128); } }
		public static Color darkblue { get { return Color(0, 0, 139); } }
		public static Color mediumblue { get { return Color(0, 0, 205); } }
		public static Color blue { get { return Color(0, 0, 255); } }
		public static Color royalblue { get { return Color(65, 105, 225); } }
		public static Color blueviolet { get { return Color(138, 43, 226); } }
		public static Color indigo { get { return Color(75, 0, 130); } }
		public static Color darkslateblue { get { return Color(72, 61, 139); } }
		public static Color slateblue { get { return Color(106, 90, 205); } }
		public static Color mediumslateblue { get { return Color(123, 104, 238); } }
		public static Color mediumpurple { get { return Color(147, 112, 219); } }
		public static Color darkmagenta { get { return Color(139, 0, 139); } }
		public static Color darkviolet { get { return Color(148, 0, 211); } }
		public static Color darkorchid { get { return Color(153, 50, 204); } }
		public static Color mediumorchid { get { return Color(186, 85, 211); } }
		public static Color purple { get { return Color(128, 0, 128); } }
		public static Color thistle { get { return Color(216, 191, 216); } }
		public static Color plum { get { return Color(221, 160, 221); } }
		public static Color violet { get { return Color(238, 130, 238); } }
		public static Color magenta { get { return Color(255, 0, 255); } }
		public static Color orchid { get { return Color(218, 112, 214); } }
		public static Color mediumvioletred { get { return Color(199, 21, 133); } }
		public static Color palevioletred { get { return Color(219, 112, 147); } }
		public static Color deeppink { get { return Color(255, 20, 147); } }
		public static Color hotpink { get { return Color(255, 105, 180); } }
		public static Color lightpink { get { return Color(255, 182, 193); } }
		public static Color pink { get { return Color(255, 192, 203); } }
		public static Color antiquewhite { get { return Color(250, 235, 215); } }
		public static Color beige { get { return Color(245, 245, 220); } }
		public static Color bisque { get { return Color(255, 228, 196); } }
		public static Color blanchedalmond { get { return Color(255, 235, 205); } }
		public static Color wheat { get { return Color(245, 222, 179); } }
		public static Color cornsilk { get { return Color(255, 248, 220); } }
		public static Color lemonchiffon { get { return Color(255, 250, 205); } }
		public static Color lightgoldenrodyellow { get { return Color(250, 250, 210); } }
		public static Color lightyellow { get { return Color(255, 255, 224); } }
		public static Color saddlebrown { get { return Color(139, 69, 19); } }
		public static Color sienna { get { return Color(160, 82, 45); } }
		public static Color chocolate { get { return Color(210, 105, 30); } }
		public static Color peru { get { return Color(205, 133, 63); } }
		public static Color sandybrown { get { return Color(244, 164, 96); } }
		public static Color burlywood { get { return Color(222, 184, 135); } }
		public static Color tan { get { return Color(210, 180, 140); } }
		public static Color rosybrown { get { return Color(188, 143, 143); } }
		public static Color moccasin { get { return Color(255, 228, 181); } }
		public static Color navajowhite { get { return Color(255, 222, 173); } }
		public static Color peachpuff { get { return Color(255, 218, 185); } }
		public static Color mistyrose { get { return Color(255, 228, 225); } }
		public static Color lavenderblush { get { return Color(255, 240, 245); } }
		public static Color linen { get { return Color(250, 240, 230); } }
		public static Color oldlace { get { return Color(253, 245, 230); } }
		public static Color papayawhip { get { return Color(255, 239, 213); } }
		public static Color seashell { get { return Color(255, 245, 238); } }
		public static Color mintcream { get { return Color(245, 255, 250); } }
		public static Color slategray { get { return Color(112, 128, 144); } }
		public static Color lightslategray { get { return Color(119, 136, 153); } }
		public static Color lightsteelblue { get { return Color(176, 196, 222); } }
		public static Color lavender { get { return Color(230, 230, 250); } }
		public static Color floralwhite { get { return Color(255, 250, 240); } }
		public static Color aliceblue { get { return Color(240, 248, 255); } }
		public static Color ghostwhite { get { return Color(248, 248, 255); } }
		public static Color honeydew { get { return Color(240, 255, 240); } }
		public static Color ivory { get { return Color(255, 255, 240); } }
		public static Color azure { get { return Color(240, 255, 255); } }
		public static Color snow { get { return Color(255, 250, 250); } }
		public static Color black { get { return Color(0, 0, 0); } }
		public static Color dimgray { get { return Color(105, 105, 105); } }
		public static Color gray { get { return Color(128, 128, 128); } }
		public static Color darkgray { get { return Color(169, 169, 169); } }
		public static Color silver { get { return Color(192, 192, 192); } }
		public static Color lightgray { get { return Color(211, 211, 211); } }
		public static Color gainsboro { get { return Color(220, 220, 220); } }
		public static Color whitesmoke { get { return Color(245, 245, 245); } }

		public static Color transparent { get { return Color(0, 0, 0, 0); } }

	}
}

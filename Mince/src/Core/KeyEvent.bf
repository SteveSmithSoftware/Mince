using System;

namespace Mince.Core
{
	public class KeyEvent : Event
	{
		public const int SCANCODE_MASK = (1 << 30);

		public KeyFlags Flags;
		public KeyCode Code;
		public ScanCode Scan;
		public bool IsRepeat;
		public char32 Char;

		public enum KeyFlags
		{
			None = 0,
			Alt = 1,
			Ctrl = 2,
			Shift = 4
		}

		public this(Object sender) : base (sender) { }
	}

	[AllowDuplicates]
	public enum KeyCode : uint32
	{
		UNKNOWN = 0,

		RETURN = (.)'\r',
		ESCAPE = 27, // '\033'
		BACKSPACE = (.)'\b',
		TAB = (.)'\t',
		SPACE = (.)' ',
		EXCLAIM = (.)'!',
		QUOTEDBL = (.)'"',
		HASH = (.)'#',
		PERCENT = (.)'%',
		DOLLAR = (.)'$',
		AMPERSAND = (.)'&',
		QUOTE = (.)'\'',
		LEFTPAREN = (.)'(',
		RIGHTPAREN = (.)')',
		ASTERISK = (.)'*',
		PLUS = (.)'+',
		COMMA = (.)',',
		MINUS = (.)'-',
		PERIOD = (.)'.',
		SLASH = (.)'/',
		Num0 = (.)'0',
		Num1 = (.)'1',
		Num2 = (.)'2',
		Num3 = (.)'3',
		Num4 = (.)'4',
		Num5 = (.)'5',
		Num6 = (.)'6',
		Num7 = (.)'7',
		Num8 = (.)'8',
		Num9 = (.)'9',
		Colon = (.)':',
		Semicolon = (.)';',
		Less = (.)'<',
		Equals = (.)'=',
		Greater = (.)'>',
		Question = (.)'?',
		AT = (.)'@',
		/*
		Skip uppercase letters
		*/
		Leftbracket = (.)'[',
		Backslash = (.)'\\',
		Rightbracket = (.)']',
		Caret = (.)'^',
		Underscore = (.)'_',
		Backquote = (.)'`',
		A = (.)'a',
		B = (.)'b',
		C = (.)'c',
		D = (.)'d',
		E = (.)'e',
		F = (.)'f',
		G = (.)'g',
		H = (.)'h',
		I = (.)'i',
		J = (.)'j',
		K = (.)'k',
		L = (.)'l',
		M = (.)'m',
		N = (.)'n',
		O = (.)'o',
		P = (.)'p',
		Q = (.)'q',
		R = (.)'r',
		S = (.)'s',
		T = (.)'t',
		U = (.)'u',
		V = (.)'v',
		W = (.)'w',
		X = (.)'x',
		Y = (.)'y',
		Z = (.)'z',

		CAPSLOCK = (int)ScanCode.CapsLock | KeyEvent.SCANCODE_MASK,

		F1 = (int)ScanCode.F1 | KeyEvent.SCANCODE_MASK,
		F2 = (int)ScanCode.F2 | KeyEvent.SCANCODE_MASK,
		F3 = (int)ScanCode.F3 | KeyEvent.SCANCODE_MASK,
		F4 = (int)ScanCode.F4 | KeyEvent.SCANCODE_MASK,
		F5 = (int)ScanCode.F5 | KeyEvent.SCANCODE_MASK,
		F6 = (int)ScanCode.F6 | KeyEvent.SCANCODE_MASK,
		F7 = (int)ScanCode.F7 | KeyEvent.SCANCODE_MASK,
		F8 = (int)ScanCode.F8 | KeyEvent.SCANCODE_MASK,
		F9 = (int)ScanCode.F9 | KeyEvent.SCANCODE_MASK,
		F10 = (int)ScanCode.F10 | KeyEvent.SCANCODE_MASK,
		F11 = (int)ScanCode.F11 | KeyEvent.SCANCODE_MASK,
		F12 = (int)ScanCode.F12 | KeyEvent.SCANCODE_MASK,

		PRINTSCREEN = (int)ScanCode.PrintScreen | KeyEvent.SCANCODE_MASK,
		SCROLLLOCK = (int)ScanCode.ScrollLock | KeyEvent.SCANCODE_MASK,
		PAUSE = (int)ScanCode.Pause | KeyEvent.SCANCODE_MASK,
		INSERT = (int)ScanCode.Insert | KeyEvent.SCANCODE_MASK,
		HOME = (int)ScanCode.Home | KeyEvent.SCANCODE_MASK,
		PAGEUP = (int)ScanCode.Pageup | KeyEvent.SCANCODE_MASK,
		DELETE = 127,
		END = (int)ScanCode.End | KeyEvent.SCANCODE_MASK,
		PAGEDOWN = (int)ScanCode.PageDown | KeyEvent.SCANCODE_MASK,
		RIGHT = (int)ScanCode.Right | KeyEvent.SCANCODE_MASK,
		LEFT = (int)ScanCode.Left | KeyEvent.SCANCODE_MASK,
		DOWN = (int)ScanCode.Down | KeyEvent.SCANCODE_MASK,
		UP = (int)ScanCode.Up | KeyEvent.SCANCODE_MASK,

		NUMLOCKCLEAR = (int)ScanCode.NumLockClear | KeyEvent.SCANCODE_MASK,
		KP_DIVIDE = (int)ScanCode.KpDivide | KeyEvent.SCANCODE_MASK,
		KPMULTIPLY = (int)ScanCode.KpMultiply | KeyEvent.SCANCODE_MASK,
		KPMINUS = (int)ScanCode.KpMinus | KeyEvent.SCANCODE_MASK,
		KPPLUS = (int)ScanCode.KpPlus | KeyEvent.SCANCODE_MASK,
		KPENTER = (int)ScanCode.KpEnter | KeyEvent.SCANCODE_MASK,
		KP1 = (int)ScanCode.Kp1 | KeyEvent.SCANCODE_MASK,
		KP2 = (int)ScanCode.Kp2 | KeyEvent.SCANCODE_MASK,
		KP3 = (int)ScanCode.Kp3 | KeyEvent.SCANCODE_MASK,
		KP4 = (int)ScanCode.Kp4 | KeyEvent.SCANCODE_MASK,
		KP5 = (int)ScanCode.Kp5 | KeyEvent.SCANCODE_MASK,
		KP6 = (int)ScanCode.Kp6 | KeyEvent.SCANCODE_MASK,
		KP7 = (int)ScanCode.Kp7 | KeyEvent.SCANCODE_MASK,
		KP8 = (int)ScanCode.Kp8 | KeyEvent.SCANCODE_MASK,
		KP9 = (int)ScanCode.Kp9 | KeyEvent.SCANCODE_MASK,
		KP0 = (int)ScanCode.Kp0 | KeyEvent.SCANCODE_MASK,
		KPPERIOD = (int)ScanCode.Kpperiod | KeyEvent.SCANCODE_MASK,

		APPLICATION = (int)ScanCode.Application | KeyEvent.SCANCODE_MASK,
		POWER = (int)ScanCode.Power | KeyEvent.SCANCODE_MASK,
		KPEQUALS = (int)ScanCode.KpEquals | KeyEvent.SCANCODE_MASK,
		F13 = (int)ScanCode.F13 | KeyEvent.SCANCODE_MASK,
		F14 = (int)ScanCode.F14 | KeyEvent.SCANCODE_MASK,
		F15 = (int)ScanCode.F15 | KeyEvent.SCANCODE_MASK,
		F16 = (int)ScanCode.F16 | KeyEvent.SCANCODE_MASK,
		F17 = (int)ScanCode.F17 | KeyEvent.SCANCODE_MASK,
		F18 = (int)ScanCode.F18 | KeyEvent.SCANCODE_MASK,
		F19 = (int)ScanCode.F19 | KeyEvent.SCANCODE_MASK,
		F20 = (int)ScanCode.F20 | KeyEvent.SCANCODE_MASK,
		F21 = (int)ScanCode.F21 | KeyEvent.SCANCODE_MASK,
		F22 = (int)ScanCode.F22 | KeyEvent.SCANCODE_MASK,
		F23 = (int)ScanCode.F23 | KeyEvent.SCANCODE_MASK,
		F24 = (int)ScanCode.F24 | KeyEvent.SCANCODE_MASK,
		EXECUTE = (int)ScanCode.Execute | KeyEvent.SCANCODE_MASK,
		HELP = (int)ScanCode.Help | KeyEvent.SCANCODE_MASK,
		MENU = (int)ScanCode.Menu | KeyEvent.SCANCODE_MASK,
		SELECT = (int)ScanCode.Select | KeyEvent.SCANCODE_MASK,
		STOP = (int)ScanCode.Stop | KeyEvent.SCANCODE_MASK,
		AGAIN = (int)ScanCode.Again | KeyEvent.SCANCODE_MASK,
		UNDO = (int)ScanCode.Undo | KeyEvent.SCANCODE_MASK,
		CUT = (int)ScanCode.Cut | KeyEvent.SCANCODE_MASK,
		COPY = (int)ScanCode.Copy | KeyEvent.SCANCODE_MASK,
		PASTE = (int)ScanCode.Paste | KeyEvent.SCANCODE_MASK,
		FIND = (int)ScanCode.Find | KeyEvent.SCANCODE_MASK,
		MUTE = (int)ScanCode.Mute | KeyEvent.SCANCODE_MASK,
		VOLUMEUP = (int)ScanCode.Volumeup | KeyEvent.SCANCODE_MASK,
		VOLUMEDOWN = (int)ScanCode.Volumedown | KeyEvent.SCANCODE_MASK,
		KP_COMMA = (int)ScanCode.KpComma | KeyEvent.SCANCODE_MASK,
		KP_EQUALSAS400 = (int)ScanCode.KpEqualsAS400 | KeyEvent.SCANCODE_MASK,

		ALTERASE = (int)ScanCode.AltErase | KeyEvent.SCANCODE_MASK,
		SYSREQ = (int)ScanCode.SysReq | KeyEvent.SCANCODE_MASK,
		CANCEL = (int)ScanCode.Cancel | KeyEvent.SCANCODE_MASK,
		CLEAR = (int)ScanCode.Clear | KeyEvent.SCANCODE_MASK,
		PRIOR = (int)ScanCode.Prior | KeyEvent.SCANCODE_MASK,
		RETURN2 = (int)ScanCode.Return2 | KeyEvent.SCANCODE_MASK,
		SEPARATOR = (int)ScanCode.Separator | KeyEvent.SCANCODE_MASK,
		OUT = (int)ScanCode.Out | KeyEvent.SCANCODE_MASK,
		OPER = (int)ScanCode.Oper | KeyEvent.SCANCODE_MASK,
		CLEARAGAIN = (int)ScanCode.ClearAgain | KeyEvent.SCANCODE_MASK,
		CRSEL = (int)ScanCode.CrSel | KeyEvent.SCANCODE_MASK,
		EXSEL = (int)ScanCode.ExSel | KeyEvent.SCANCODE_MASK,

		KP00 = (int)ScanCode.Kp00 | KeyEvent.SCANCODE_MASK,
		KP000 = (int)ScanCode.Kp00 | KeyEvent.SCANCODE_MASK,
		THOUSANDSSEPARATOR = (int)ScanCode.Thousandsseparator | KeyEvent.SCANCODE_MASK,
		DECIMALSEPARATOR = (int)ScanCode.Decimalseparator | KeyEvent.SCANCODE_MASK,
		CURRENCYUNIT = (int)ScanCode.Currencyunit | KeyEvent.SCANCODE_MASK,
		CURRENCYSUBUNIT = (int)ScanCode.Currencysubunit | KeyEvent.SCANCODE_MASK,
		KPLEFTPAREN = (int)ScanCode.Kpleftparen | KeyEvent.SCANCODE_MASK,
		KPRIGHTPAREN = (int)ScanCode.Kprightparen | KeyEvent.SCANCODE_MASK,
		KPLEFTBRACE = (int)ScanCode.Kpleftbrace | KeyEvent.SCANCODE_MASK,
		KPRIGHTBRACE = (int)ScanCode.Kprightbrace | KeyEvent.SCANCODE_MASK,
		KPTAB = (int)ScanCode.Kptab | KeyEvent.SCANCODE_MASK,
		KPBACKSPACE = (int)ScanCode.Kpbackspace | KeyEvent.SCANCODE_MASK,
		KPA = (int)ScanCode.KPA | KeyEvent.SCANCODE_MASK,
		KPB = (int)ScanCode.KPB | KeyEvent.SCANCODE_MASK,
		KPC = (int)ScanCode.KPC | KeyEvent.SCANCODE_MASK,
		KPD = (int)ScanCode.KPD | KeyEvent.SCANCODE_MASK,
		KPE = (int)ScanCode.KPE | KeyEvent.SCANCODE_MASK,
		KPF = (int)ScanCode.KPF | KeyEvent.SCANCODE_MASK,
		KPXOR = (int)ScanCode.KpXor | KeyEvent.SCANCODE_MASK,
		KPPOWER = (int)ScanCode.KpPower | KeyEvent.SCANCODE_MASK,
		KPPERCENT = (int)ScanCode.KpPercent | KeyEvent.SCANCODE_MASK,
		KPLESS = (int)ScanCode.KpLess | KeyEvent.SCANCODE_MASK,
		KPGREATER = (int)ScanCode.KpGreater | KeyEvent.SCANCODE_MASK,
		KPAMPERSAND = (int)ScanCode.KpAmpersand | KeyEvent.SCANCODE_MASK,
		KPDBLAMPERSAND = (int)ScanCode.KpdBlAmpersand | KeyEvent.SCANCODE_MASK,
		KPVERTICALBAR = (int)ScanCode.KpVerticalBar | KeyEvent.SCANCODE_MASK,
		KPDBLVERTICALBAR = (int)ScanCode.KpDblVerticalBar | KeyEvent.SCANCODE_MASK,
		KPCOLON = (int)ScanCode.KpColon | KeyEvent.SCANCODE_MASK,
		KPHASH = (int)ScanCode.KpHash | KeyEvent.SCANCODE_MASK,
		KPSPACE = (int)ScanCode.KpSpace | KeyEvent.SCANCODE_MASK,
		KPAT = (int)ScanCode.KPA | KeyEvent.SCANCODE_MASK,
		KPEXCLAM = (int)ScanCode.KpExclam | KeyEvent.SCANCODE_MASK,
		KPMEMSTORE = (int)ScanCode.KpMemstore | KeyEvent.SCANCODE_MASK,
		KPMEMRECALL = (int)ScanCode.KpMemrecall | KeyEvent.SCANCODE_MASK,
		KPMEMCLEAR = (int)ScanCode.KpMemclear | KeyEvent.SCANCODE_MASK,
		KPMEMADD = (int)ScanCode.KpMemadd | KeyEvent.SCANCODE_MASK,
		KPMEMSUBTRACT = (int)ScanCode.KpMemsubtract | KeyEvent.SCANCODE_MASK,
		KPMEMMULTIPLY = (int)ScanCode.KpMemmultiply | KeyEvent.SCANCODE_MASK,
		KPMEMDIVIDE = (int)ScanCode.KpMemdivide | KeyEvent.SCANCODE_MASK,
		KPPLUSMINUS = (int)ScanCode.KpPlusminus | KeyEvent.SCANCODE_MASK,
		KPCLEAR = (int)ScanCode.KpClear | KeyEvent.SCANCODE_MASK,
		KPCLEARENTRY = (int)ScanCode.KpClearentry | KeyEvent.SCANCODE_MASK,
		KPBINARY = (int)ScanCode.KpBinary | KeyEvent.SCANCODE_MASK,
		KPOCTAL = (int)ScanCode.KpOctal | KeyEvent.SCANCODE_MASK,
		KPDECIMAL = (int)ScanCode.KpDecimal | KeyEvent.SCANCODE_MASK,
		KPHEXADECIMAL =	 (int)ScanCode.KpHexadecimal | KeyEvent.SCANCODE_MASK,

		LCTRL = (int)ScanCode.LCtrl | KeyEvent.SCANCODE_MASK,
		LSHIFT = (int)ScanCode.LShift | KeyEvent.SCANCODE_MASK,
		LALT = (int)ScanCode.LAlt | KeyEvent.SCANCODE_MASK,
		LGUI = (int)ScanCode.LGui | KeyEvent.SCANCODE_MASK,
		RCTRL = (int)ScanCode.RCtrl | KeyEvent.SCANCODE_MASK,
		RSHIFT = (int)ScanCode.RShift | KeyEvent.SCANCODE_MASK,
		RALT = (int)ScanCode.RAlt | KeyEvent.SCANCODE_MASK,
		RGUI = (int)ScanCode.RGui | KeyEvent.SCANCODE_MASK,

		MODE = (int)ScanCode.Mode | KeyEvent.SCANCODE_MASK,

		AUDIONEXT = (int)ScanCode.Audionext | KeyEvent.SCANCODE_MASK,
		AUDIOPREV = (int)ScanCode.Audioprev | KeyEvent.SCANCODE_MASK,
		AUDIOSTOP = (int)ScanCode.Audiostop | KeyEvent.SCANCODE_MASK,
		AUDIOPLAY = (int)ScanCode.Audioplay | KeyEvent.SCANCODE_MASK,
		AUDIOMUTE = (int)ScanCode.Audiomute | KeyEvent.SCANCODE_MASK,
		MEDIASELECT = (int)ScanCode.Mediaselect | KeyEvent.SCANCODE_MASK,
		WWW = (int)ScanCode.Www | KeyEvent.SCANCODE_MASK,
		MAIL = (int)ScanCode.Mail | KeyEvent.SCANCODE_MASK,
		CALCULATOR = (int)ScanCode.Calculator | KeyEvent.SCANCODE_MASK,
		COMPUTER = (int)ScanCode.Computer | KeyEvent.SCANCODE_MASK,
		ACSEARCH = (int)ScanCode.Acsearch | KeyEvent.SCANCODE_MASK,
		ACHOME = (int)ScanCode.Achome | KeyEvent.SCANCODE_MASK,
		ACBACK = (int)ScanCode.Acback | KeyEvent.SCANCODE_MASK,
		ACFORWARD = (int)ScanCode.Acforward | KeyEvent.SCANCODE_MASK,
		ACSTOP = (int)ScanCode.Acstop | KeyEvent.SCANCODE_MASK,
		ACREFRESH = (int)ScanCode.Acrefresh | KeyEvent.SCANCODE_MASK,
		ACBOOKMARKS = (int)ScanCode.Acbookmarks | KeyEvent.SCANCODE_MASK,

		BRIGHTNESSDOWN =
			(int)ScanCode.Brightnessdown | KeyEvent.SCANCODE_MASK,
			BRIGHTNESSUP = (int)ScanCode.Brightnessup | KeyEvent.SCANCODE_MASK,
			DISPLAYSWITCH = (int)ScanCode.Displayswitch | KeyEvent.SCANCODE_MASK,
			KBDILLUMTOGGLE =
		(int)ScanCode.KbdIllumtoggle | KeyEvent.SCANCODE_MASK,
			KBDILLUMDOWN = (int)ScanCode.KbdIllumdown | KeyEvent.SCANCODE_MASK,
			KBDILLUMUP = (int)ScanCode.KbdIllumup | KeyEvent.SCANCODE_MASK,
			EJECT = (int)ScanCode.Eject | KeyEvent.SCANCODE_MASK,
			SLEEP = (int)ScanCode.Sleep | KeyEvent.SCANCODE_MASK
	}

	/* ScanCodes based off USB keyboard page (0x07) */
	public enum ScanCode : uint32
	{
		UNKNOWN = 0,

		A = 4,
		B = 5,
		C = 6,
		D = 7,
		E = 8,
		F = 9,
		G = 10,
		H = 11,
		I = 12,
		J = 13,
		K = 14,
		L = 15,
		M = 16,
		N = 17,
		O = 18,
		P = 19,
		Q = 20,
		R = 21,
		S = 22,
		T = 23,
		U = 24,
		V = 25,
		W = 26,
		X = 27,
		Y = 28,
		Z = 29,

		Key1 = 30,
		Key2 = 31,
		Key3 = 32,
		Key4 = 33,
		Key5 = 34,
		Key6 = 35,
		Key7 = 36,
		Key8 = 37,
		Key9 = 38,
		Key0 = 39,

		Return = 40,
		Escape = 41,
		BackSpace = 42,
		Tab = 43,
		Space = 44,

		Minus = 45,
		Equals = 46,
		LeftBracket = 47,
		RightBracket = 48,
		BackSlash = 49,
		NonUSHash = 50,
		Semicolon = 51,
		Apostrophe = 52,
		Grave = 53,
		Comma = 54,
		Period = 55,
		Slash = 56,

		CapsLock = 57,

		F1 = 58,
		F2 = 59,
		F3 = 60,
		F4 = 61,
		F5 = 62,
		F6 = 63,
		F7 = 64,
		F8 = 65,
		F9 = 66,
		F10 = 67,
		F11 = 68,
		F12 = 69,

		PrintScreen = 70,
		ScrollLock = 71,
		Pause = 72,
		Insert = 73,
		Home = 74,
		Pageup = 75,
		Delete = 76,
		End = 77,
		PageDown = 78,
		Right = 79,
		Left = 80,
		Down = 81,
		Up = 82,

		NumLockClear = 83,
		KpDivide = 84,
		KpMultiply = 85,
		KpMinus = 86,
		KpPlus = 87,
		KpEnter = 88,
		Kp1 = 89,
		Kp2 = 90,
		Kp3 = 91,
		Kp4 = 92,
		Kp5 = 93,
		Kp6 = 94,
		Kp7 = 95,
		Kp8 = 96,
		Kp9 = 97,
		Kp0 = 98,
		Kpperiod = 99,

		NonUSBackslash = 100,
		Application = 101,
		Power = 102,
		KpEquals = 103,
		F13 = 104,
		F14 = 105,
		F15 = 106,
		F16 = 107,
		F17 = 108,
		F18 = 109,
		F19 = 110,
		F20 = 111,
		F21 = 112,
		F22 = 113,
		F23 = 114,
		F24 = 115,
		Execute = 116,
		Help = 117,
		Menu = 118,
		Select = 119,
		Stop = 120,
		Again = 121,
		Undo = 122,
		Cut = 123,
		Copy = 124,
		Paste = 125,
		Find = 126,
		Mute = 127,
		Volumeup = 128,
		Volumedown = 129,
		/* not sure whether there's a reason to enable these */
		/*	lockingcapslock = 130, */
		/*	lockingnumlock = 131, */
		/*	lockingscrolllock = 132, */
		KpComma = 133,
		KpEqualsAS400 = 134,

		International1 = 135,
		International2 = 136,
		International3 = 137,
		International4 = 138,
		International5 = 139,
		International6 = 140,
		International7 = 141,
		International8 = 142,
		International9 = 143,
		Lang1 = 144,
		Lang2 = 145,
		Lang3 = 146,
		Lang4 = 147,
		Lang5 = 148,
		Lang6 = 149,
		Lang7 = 150,
		Lang8 = 151,
		Lang9 = 152,

		AltErase = 153,
		SysReq = 154,
		Cancel = 155,
		Clear = 156,
		Prior = 157,
		Return2 = 158,
		Separator = 159,
		Out = 160,
		Oper = 161,
		ClearAgain = 162,
		CrSel = 163,
		ExSel = 164,

		Kp00 = 176,
		Kp000 = 177,
		Thousandsseparator = 178,
		Decimalseparator = 179,
		Currencyunit = 180,
		Currencysubunit = 181,
		Kpleftparen = 182,
		Kprightparen = 183,
		Kpleftbrace = 184,
		Kprightbrace = 185,
		Kptab = 186,
		Kpbackspace = 187,
		KPA = 188,
		KPB = 189,
		KPC = 190,
		KPD = 191,
		KPE = 192,
		KPF = 193,
		KpXor = 194,
		KpPower = 195,
		KpPercent = 196,
		KpLess = 197,
		KpGreater = 198,
		KpAmpersand = 199,
		KpdBlAmpersand = 200,
		KpVerticalBar = 201,
		KpDblVerticalBar = 202,
		KpColon = 203,
		KpHash = 204,
		KpSpace = 205,
		KpAt = 206,
		KpExclam = 207,
		KpMemstore = 208,
		KpMemrecall = 209,
		KpMemclear = 210,
		KpMemadd = 211,
		KpMemsubtract = 212,
		KpMemmultiply = 213,
		KpMemdivide = 214,
		KpPlusminus = 215,
		KpClear = 216,
		KpClearentry = 217,
		KpBinary = 218,
		KpOctal = 219,
		KpDecimal = 220,
		KpHexadecimal = 221,

		LCtrl = 224,
		LShift = 225,
		LAlt = 226,
		LGui = 227,
		RCtrl = 228,
		RShift = 229,
		RAlt = 230,
		RGui = 231,

		Mode = 257,

		/* these come from the usb consumer page (0x0c) */
		Audionext = 258,
		Audioprev = 259,
		Audiostop = 260,
		Audioplay = 261,
		Audiomute = 262,
		Mediaselect = 263,
		Www = 264,
		Mail = 265,
		Calculator = 266,
		Computer = 267,
		Acsearch = 268,
		Achome = 269,
		Acback = 270,
		Acforward = 271,
		Acstop = 272,
		Acrefresh = 273,
		Acbookmarks = 274,

		/* these come from other sources, and are mostly mac related */
		Brightnessdown = 275,
		Brightnessup = 276,
		Displayswitch = 277,
		KbdIllumtoggle = 278,
		KbdIllumdown = 279,
		KbdIllumup = 280,
		Eject = 281,
		Sleep = 282,

		App1 = 283,
		App2 = 284
	}
}


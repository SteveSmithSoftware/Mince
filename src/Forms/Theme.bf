using Mince.Core;

namespace Mince.Forms
{
	public static class Theme
	{
		public static Color toolStripBg = Color.gainsboro;
		public static Color formBg = Color.silver;
		public static Color statusBarBg = Color.gainsboro;
		public static Color panelBorder = Color.lightslategray;
		public static Color text = Color.black;
		public static Color buttonBg = Color.lightslategray;
		public static Color buttonBorder = Color.white;
		public static Color buttonText = Color.white;
		public static Color scrollBg = Color.lightslategray;
		public static Color scrollThumb = Color.darkgray;

        public enum ImageIdx
        {
            Bkg,
            Window,
            Dots,
            RadioOn,
            RadioOff,
            MainBtnUp,
            MainBtnDown,
            BtnUp,
            BtnOver,
            BtnDown,
            Separator,
            TabActive,
            TabActiveOver,
            TabInactive,
            TabInactiveOver,            
            EditBox,
            Checkbox,
            CheckboxOver,
            CheckboxDown,
            Check,

            Close,
            CloseOver,
            DownArrow,
            GlowDot,
            ArrowRight,
            WhiteCircle,
            DropMenuButton,
            ListViewHeader,
            ListViewSortArrow,
            Outline,
            Scrollbar,
            ScrollbarThumbOver,
            ScrollbarThumb,
            ScrollbarArrow,
            ShortButton,
            ShortButtonDown,
            VertScrollbar,
            VertScrollbarThumbOver,
            VertScrollbarThumb,
            VertScrollbarArrow,

            VertShortButton,
            VertShortButtonDown,
            Grabber,
            DropShadow,
            Menu,
            MenuSepVert,
            MenuSepHorz,
            MenuSelect,
            TreeArrow,
            UIPointer,
            UIImage,
            UIComposition,
            UILabel,
            UIButton,
            UIEdit,
            UICombobox,
            UICheckbox,
            UIRadioButton,
            UIListView,
            UITabView,

            EditCorners,
            EditCircle,
            EditPathNode,
            EditPathNodeSelected,
            EditAnchor,
            UIBone,
            UIBoneJoint,
            VisibleIcon,
            LockIcon,
            LeftArrow,
            KeyframeMakeOff,
            RightArrow,
            LeftArrowDisabled,
            KeyframeMakeOn,
            RightArrowDisabled,
            TimelineSelector,
            TimelineBracket,
            KeyframeOff,
            KeyframeOn,
            LinkedIcon,

            CheckboxLarge,
            ComboBox,
            ComboEnd,
            ComboSelectedIcon,
            LinePointer,
            RedDot,
            Document,
            ReturnPointer,
            RefreshArrows,
            MoveDownArrow,
            IconObject,
            IconObjectDeleted,
            IconObjectAppend,
            IconObjectStack,
            IconValue,
            IconPointer,
            IconType,
            IconError,
            IconBookmark,
            ProjectFolder,

            Project,
            ArrowMoveDown,
            Workspace,
            MemoryArrowSingle,
            MemoryArrowDoubleTop,
            MemoryArrowDoubleBottom,
            MemoryArrowTripleTop,
            MemoryArrowTripleMiddle,
            MemoryArrowTripleBottom,
            MemoryArrowRainbow,
            Namespace,
            ResizeGrabber,
            AsmArrow,
            AsmArrowRev,
            AsmArrowShadow,
            MenuNonFocusSelect,
            StepFilter,
            WaitSegment,
            FindCaseSensitive,
            FindWholeWord,

            RedDotUnbound,
            MoreInfo,
            Interface,
            Property,
            Field,
            Method,
            Variable,
            Constant,

            Type_ValueType,
            Type_Class,

			LinePointer_Prev,
			LinePointer_Opt,
			RedDotEx,
			RedDotExUnbound,
			RedDotDisabled,
			RedDotExDisabled,
			RedDotRunToCursor,

			GotoButton,
			YesJmp,
			NoJmp,
			WhiteBox,
			UpDownArrows,
			EventInfo,
			WaitBar,
			HiliteOutline,
			HiliteOutlineThin,

			IconPayloadEnum,
			StepFilteredDefault,

			ThreadBreakpointMatch,
			ThreadBreakpointNoMatch,
			ThreadBreakpointUnbound,
			Search,
			CheckIndeterminate,
			CodeError,
			CodeWarning,
			ComboBoxFrameless,
			PanelHeader,

			ExtMethod,

			COUNT,

			None


        };

	}
}

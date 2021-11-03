using System;
using System.Collections;
using Mince.Core;

namespace Mince.Forms
{
	public class Window
	{
		List<Control> controls = new .();
		String title = new String() ~ delete _;
		Rect rect = Rect();

		Graphics graphics;

		Queue<Graphics.Texture> textures = new .();
		List<Control> affected = new List<Control>() ~ delete _;

		public bool hasTooStrip = true;
		public Panel ToolStrip;
		public Panel Form;
		public bool hasStatusBar = true;
		public Panel StatusBar;

		public this(StringView title, Size size) {
			rect.Size = size;
			graphics = new Graphics(this, title, Point(0,0), size);
			graphics.paint.Add( new => this.Paint);
			graphics.keydown.Add( new => this.KeyDown);
			graphics.keyup.Add( new => this.KeyUp);
			graphics.mousedown.Add( new => this.MouseDown);
			graphics.mouseup.Add( new => this.MouseUp);
			graphics.mousescroll.Add( new => this.MouseScroll);
			graphics.mousemove.Add( new => this.MouseMove);

			int32 usedH = 0;
			int32 tsH=50;
			if (hasTooStrip) {
				ToolStrip = new Panel(this, Rect(0,0,size.Width,tsH));
				ToolStrip.Background.Color=Theme.toolStripBg;
				ToolStrip.hasFrame=true;
				usedH+=tsH;
			} else tsH=0;

			int32 sbH=30;
			if (hasStatusBar) {
				StatusBar = new Panel(this, Rect(0,size.Height-sbH,size.Width,sbH));
				StatusBar.Background.Color=Theme.statusBarBg;
				StatusBar.hasFrame=true;
				usedH+=sbH;
			} else sbH=0;

			Form = new Panel(this, Rect(0,tsH,size.Width,size.Height-usedH),true,true);
			Form.Background.Color=Theme.formBg;
		}
		
		public ~this() {
			if (controls != null) DeleteAndNullify!(controls);
			if (textures != null) DeleteAndNullify!(textures);
			if (graphics != null) DeleteAndNullify!(graphics);
			if (ToolStrip != null) DeleteAndNullify!(ToolStrip);
			if (Form != null) DeleteAndNullify!(Form);
			if (StatusBar != null) DeleteAndNullify!(StatusBar);
}
		
		public void Run() {
			graphics.Loop();
		}

		public void Add(Control control) {
			controls.Add(control);
		}

		public void AddTexture(Graphics.Texture texture) {
			textures.Enqueue(texture);
		}

		public Graphics.Texture GetTexture() {
			if (textures.Count>0) return textures.Dequeue();
			return null;
		}

		public Graphics GetContext() {
			return graphics;
		}

		public void Paint() {
			for (Control c in controls) {
				if (c.isVisible) c.Paint();
			}
		};

		public void KeyDown(KeyEvent event) {
			invokeAffected(event);
		}

		public void KeyUp(KeyEvent event) {
			invokeAffected(event);
		}

		public void MouseDown(MouseEvent event) {
			findAffected(event.Position);
			invokeAffected(event);
		}

		public void MouseUp(MouseEvent event) {
			findAffected(event.Position);
			invokeAffected(event);
		}

		public void MouseScroll(MouseEvent event) {
			findAffected(event.Position);
			invokeAffected(event);
		}

		public void MouseMove(MouseEvent event) {
			findAffected(event.Position,true);
			invokeAffected(event);
		}

		void findAffected(Point p, bool all=false) {
			affected.Clear();
			for (Control child in controls) {
				if (child.Rect.Contains(p)) {
					affected.Add(child);
					if (!child.isMouseOver) child.Mouseenter=true;
					else child.Mouseenter=false;
					child.isMouseOver=true;
					child.FindAffected(p, ref affected);
					if (!all) break;
				} else {
					if (child.isMouseOver) {
						child.Mouseexit=true;
						child.isMouseOver=false;
						affected.Add(child);
					} else {
						child.Mouseexit=false;
					}
					child.FindAffected(p, ref affected ,all);
				}
			}
		}

		bool invokeAffected(Event event) {
			for (int i=affected.Count-1;i>=0;i--) {
				switch (event.Event) {
				case Event.EventType.KeyDown:
					if (affected[i].KeyDown((KeyEvent)event)) {
						if (!event.Bubble) return true;
					}
					break;
				case Event.EventType.KeyUp:
					if (affected[i].KeyUp((KeyEvent)event)) {
						if (!event.Bubble) return true;
					}
					break;
				case Event.EventType.MouseDown:
					if (affected[i].MouseDown((MouseEvent)event)) {
						if (!event.Bubble) return true;
					}
					break;
				case Event.EventType.MouseUp:
					if (affected[i].MouseUp((MouseEvent)event)) {
						if (!event.Bubble) return true;
					}
					break;
				case Event.EventType.MouseMove:
					affected[i].MouseMove((MouseEvent)event);
					if (!event.Bubble) return true;
					break;
				case Event.EventType.MouseScroll:
					if (affected[i].MouseScroll((MouseEvent)event)) {
						if (!event.Bubble) return true;
					}
					break;
				default:
					break;
				}
			}
			return false;
		}
	}
}

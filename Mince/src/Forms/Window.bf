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
		Queue<Graphics.Texture> menus = new .();
		List<Control> affected = new List<Control>() ~ delete _;

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
		}
		
		public ~this() {
			if (controls != null) DeleteAndNullify!(controls);
			if (textures != null) DeleteAndNullify!(textures);
			if (menus != null) DeleteAndNullify!(menus);
			if (graphics != null) DeleteAndNullify!(graphics);
		}
		
		public void Run() {
			graphics.Loop();
		}

		public void Add(Control control) {
			controls.Add(control);
		}

		public void AddTexture(Graphics.Texture texture) {
			if (texture.IsMenu) {
				menus.Enqueue(texture);
			}
			else {
				textures.Enqueue(texture);
			}
		}

		public Graphics.Texture GetTexture() {
			if (textures.Count>0) return textures.Dequeue();
			if (menus.Count>0) {
				return menus.Dequeue();
			}
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
					child.FindAffected(p, ref affected, all);
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

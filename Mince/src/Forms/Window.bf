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
		const int Zlevels=6;
		Queue<Graphics.Texture>[] textures = new Queue<Graphics.Texture>[Zlevels];
		List<Control>[] affected = new List<Control>[Zlevels];

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
			for (int z=0;z<Zlevels;z++) {
				textures[z] = new Queue<SDL2.Texture>();
				affected[z] = new List<Control>();
			}
		}
		
		public ~this() {
			if (controls != null) DeleteAndNullify!(controls);
			for (int i=0;i<Zlevels;i++ ) {
				DeleteAndNullify!(textures[i]);
				DeleteAndNullify!(affected[i]);
			}
			DeleteAndNullify!(textures);
			DeleteAndNullify!(affected);
			if (graphics != null) DeleteAndNullify!(graphics);
		}
		
		public void Run() {
			graphics.Loop();
		}

		public void Add(Control control) {
			controls.Add(control);
		}

		public void AddTexture(Graphics.Texture texture) {
			textures[texture.Rect.Z].Enqueue(texture);
		}

		public Graphics.Texture GetTexture() {
			for (int i=0;i<Zlevels;i++) {
				if (textures[i].Count>0) return textures[i].Dequeue();
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
			for (int z=0;z<Zlevels;z++) if (affected[z].Count>0) affected[z].Clear();
			for (Control child in controls) {
				if (child.isVisible) {
					if (child.Rect.Contains(p)) {
						affected[child.Rect.Z].Add(child);
						if (!child.isMouseOver) child.Mouseenter=true;
						else child.Mouseenter=false;
						child.isMouseOver=true;
						child.FindAffected(p, ref affected, all);
						if (!all) break;
					} else {
						if (child.isMouseOver) {
							child.Mouseexit=true;
							child.isMouseOver=false;
							affected[child.Rect.Z].Add(child);
						} else {
							child.Mouseexit=false;
						}
						child.FindAffected(p, ref affected ,all);
					}
				}
			}
		}

		bool invokeAffected(Event event) {
			for (int z=Zlevels-1;z>=0;z--) {
				for (int i=affected[z].Count-1;i>=0;i--) {
					if (event.Event != Event.EventType.MouseMove && !affected[z][i].hasFocus) continue;
					switch (event.Event) {
					case Event.EventType.KeyDown:
						if (affected[z][i].KeyDown((KeyEvent)event)) {
							if (!event.Bubble) return true;
						}
						break;
					case Event.EventType.KeyUp:
						if (affected[z][i].KeyUp((KeyEvent)event)) {
							if (!event.Bubble) return true;
						}
						break;
					case Event.EventType.MouseDown:
						if (affected[z][i].MouseDown((MouseEvent)event)) {
							if (!event.Bubble) return true;
						}
						break;
					case Event.EventType.MouseUp:
						if (affected[z][i].MouseUp((MouseEvent)event)) {
							if (!event.Bubble) return true;
						}
						break;
					case Event.EventType.MouseMove:
						affected[z][i].MouseMove((MouseEvent)event);
						break;
					case Event.EventType.MouseScroll:
						if (affected[z][i].MouseScroll((MouseEvent)event)) {
							if (!event.Bubble) return true;
						}
						break;
					default:
						break;
					}
				}
			}
			return false;
		}
	}
}

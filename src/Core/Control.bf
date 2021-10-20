using System;
using System.Collections;
using Mince.Forms;
typealias Graphics = Mince.Core.SDL2;

namespace Mince.Core
{
	public abstract class Control
	{
		public Rect Rect;
		public bool IsDirty=true;
		public Background Background;
		public Frame Frame;
		public bool isVisible=true;
		public bool hasFrame=false;
		Window window;
		public Control Parent;
		List<Control> children = new .();
		
		public Graphics.Texture texture;

		public virtual bool KeyUp(KeyEvent event) {
			 return false;
		}
		public virtual bool KeyDown(KeyEvent event) { return false; }
		public virtual bool KeyPress(KeyEvent event) { return false; }
		public virtual bool MouseDown(MouseEvent event) { return false; }
		public virtual bool MouseUp(MouseEvent event) { return false; }
		public virtual bool MouseMove(MouseEvent event) { return false; }
		public virtual bool MouseScroll(MouseEvent event) { return false; }

		protected abstract void fillTexture(Rect rect);

		public this() {

		}
		
		public ~this() {
			if (children != null) {
				for (Control child in children) {
					DeleteAndNullify!(child);
				}
				DeleteAndNullify!(children);
			}
			if (texture != null) DeleteAndNullify!(texture);
		}
		
		public this(Window window, Rect rect) {
			this.window = window;
			Parent = null;
			window.Add(this);
			Rect = rect;
			texture = new Graphics.Texture(rect);
		}

		public this(Control parent, Rect rect) {
			this.window = null;
			Parent = parent;
			parent.Add(this);
			Rect = rect;
			Rect.Position.Add(Parent.Rect.Position);
			texture = new Graphics.Texture(rect);
		}

		public void Add(Control control) {
			children.Add(control);
		}

		public Graphics GetContext() {
			if (Parent != null) {
				return Parent.GetContext();
			}
			return window.GetContext();
		}

		public virtual void Paint() {
			Paint(Rect);
		}

		protected virtual void Paint(Rect rect) {
			if (IsDirty) fillTexture(rect);
			IsDirty=false;
			texture.Rect = rect;
			AddTexture(texture);
			for (Control child in children) {
				child.Paint();
			}
		}

		public void AddTexture(Graphics.Texture texture) {
			if (Parent != null) {
				Parent.AddTexture(texture);
			} else {
				window.AddTexture(texture);
			}
		}

		public void FindAffected(Point p, ref List<Control> affected) {
			for (Control child in children) {
				if (child.Rect.Contains(p)) {
					affected.Add(child);
					child.FindAffected(p, ref affected);
					break;
				}
			}
		}

	}
}

using System;
using System.Collections;
using Mince.Forms;
typealias Graphics = Mince.Core.SDL2;

namespace Mince.Core
{
	public abstract class Control
	{
		public static int32 defaultZ=2;
		public static int32 menuZ=4;


		public Rect Rect;
		public bool IsDirty=true;
		public bool isVisible=true;
		public bool hasFocus=false;
		protected bool mousedown=false;
		public bool isMouseOver=false;
		public bool Mouseenter=false;
		public bool Mouseexit=false;
		Window window;
		public Control Parent;
		protected List<Control> children = new .();
		
		public Graphics.Texture texture;

		public int32 Width {
			get { return Rect.Size.Width; }
			set {
				if (texture != null) delete texture;
				Rect.Size.Width = value;
				texture = new Graphics.Texture(Rect);
				IsDirty=true;
			}
		}

		public int32 Height {
			get { return Rect.Size.Height; }
			set {
				if (texture != null) delete texture;
				Rect.Size.Height = value;
				texture = new Graphics.Texture(Rect);
				IsDirty=true;
			}
		}

		public Rect DisplayRect {
			get { if (texture != null) return texture.DisplayRect; else return Rect(0,0,Rect.Size.Width, Rect.Size.Height); }
			set {
				if (texture != null) {
					texture.DisplayRect = value;
					Rect r = value;
					r.Position.X += Rect.Position.X;
					r.Position.Y += Rect.Position.Y;
					for (Control child in children) {
						if (r.Contains(child.Rect)) child.isVisible=true; else child.isVisible=false;
					}
				}
			}
		}

		protected bool hasChildren {
			get { return children.Count > 0; }
		}

		public virtual bool KeyUp(KeyEvent event) { return false; }
		public virtual bool KeyDown(KeyEvent event) { return false; }
		public virtual bool KeyPress(KeyEvent event) { return false; }
		public virtual bool MouseDown(MouseEvent event) { return false; }
		public virtual bool MouseUp(MouseEvent event) { mousedown=false; return false; }
		public virtual void MouseMove(MouseEvent event) {
			if (Mouseenter) {
				hasFocus=true;
				MouseEnter(event);
			} else if (Mouseexit) {
				MouseExit(event);
				hasFocus=false;
			}
		}
		public virtual bool MouseScroll(MouseEvent event) { return false; }
		public virtual void MouseEnter(MouseEvent event) {  }
		public virtual void MouseExit(MouseEvent event) { mousedown=false; }

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
		
		public this(Object parent, Rect rect) {
			Rect = rect;
			if (parent is Control) {
				window = null;
				Parent = (Control)parent;
				Parent.Add(this);
				Rect.Position.Add(Parent.Rect.Position);
			} else {
				window = (Window)parent;
				Parent = null;
				window.Add(this);
			}
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
			if (isVisible) {
				Paint(Rect);
			}
		}

		protected virtual void Paint(Rect rect) {
			if (IsDirty) fillTexture(rect);
			IsDirty=false;
			texture.Rect = rect;
			AddTexture(texture);
			for (Control child in children) {
				if (child.isVisible) child.Paint();
			}
		}

		public void AddTexture(Graphics.Texture texture) {
			if (Parent != null) {
				Parent.AddTexture(texture);
			} else {
				window.AddTexture(texture);
			}
		}

		public void FindAffected(Point p, ref List<Control>[] affected, bool all=false) {
			for (Control child in children) {
				if (child.isVisible) {
					if (child.Rect.Contains(p)) {
						if (!child.isMouseOver) child.Mouseenter=true;
						else child.Mouseenter=false;
						child.isMouseOver=true;
						affected[child.Rect.Z].Add(child);
						child.FindAffected(p, ref affected ,all);
						if (!all) break;
					} else {
						if (child.isMouseOver) {
							child.isMouseOver=false;
							child.Mouseexit=true;
							affected[child.Rect.Z].Add(child);
						} else child.Mouseexit=false;
						child.FindAffected(p, ref affected ,all);
					}
				}
			}
		}

	}
}

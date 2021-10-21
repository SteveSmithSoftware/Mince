using System;
using System.Collections;
using System.Diagnostics;
using System.Threading;
using SDL2;

namespace Mince.Core
{
	public class SDL2
	{
		Mince.Forms.Window parent;
		SDL.Window* window;
		SDL.Renderer* renderer;
		SDL.Surface* screen;
		SDL.Surface*[] iconsS = new SDL.Surface*[(int32)Forms.Theme.ImageIdx.COUNT];
		//SDL.Texture*[] iconsT = new SDL.Texture*[(int32)Forms.Theme.ImageIdx.COUNT];

		uint32 rmask = 0xff000000;
		uint32 gmask = 0x00ff0000;
		uint32 bmask = 0x0000ff00;
		uint32 amask = 0x000000ff;

		public int32 updateCnt;
		public bool* keyboardState;

		public System.Event<Action> paint ~ _.Dispose();
		public System.Event<Action> update ~ _.Dispose();
		public System.Event<Action> quit ~ _.Dispose();
		public System.Event<KeyDlg> keyup ~ _.Dispose();
		public System.Event<KeyDlg> keydown ~ _.Dispose();
		public System.Event<MouseDlg> mouseup ~ _.Dispose();
		public System.Event<MouseDlg> mousedown ~ _.Dispose();
		public System.Event<MouseDlg> mousemove ~ _.Dispose();
		public System.Event<MouseDlg> mousescroll ~ _.Dispose();
		public System.Event<EventDlg> genericevent ~ _.Dispose();

		KeyEvent keyevent = new KeyEvent(this) ~ delete _;
		MouseEvent mouseevent = new MouseEvent(this) ~ delete _;
		Event event = new Event(this) ~ delete _;

		Thread loopThread;

		public ~this()
		{
			if (renderer != null)
				SDL.DestroyRenderer(renderer);
			if (window != null)
				SDL.DestroyWindow(window);
			SDLTTF.Quit();
			for (int32 i = 0; i < (int32)Forms.Theme.ImageIdx.COUNT; i++)
			{
				if (iconsS[i] != null) SDL.FreeSurface(iconsS[i]);
				//if (iconsT[i] != null) SDL.DestroyTexture(iconsT[i]);
			}
			DeleteAndNullify!(iconsS);
			//DeleteAndNullify!(iconsT);
		}

		public this(Mince.Forms.Window parent, StringView title, Point position, Size size)
		{
			this.parent = parent;
			String t = scope String();
			title.ToString(t);
			SDL.Init(.Video | .Events | .Audio);
			window = SDL.CreateWindow(t, .Undefined, .Undefined, size.Width, size.Height, .Resizable);
			renderer = SDL.CreateRenderer(window, -1, .Accelerated);
			screen = SDL.GetWindowSurface(window);
			SDLTTF.Init();
			CreateIcons();
			SDL.SetWindowIcon(window, iconsS[(int)Forms.Theme.ImageIdx.Project]);

			//loopThread = new Thread(new => this.Loop);
			//loopThread.Start();
		}

		public void Loop()
		{
			Stopwatch sw = scope .();
			sw.Start();
			int curPhysTickCount = 0;
			Paint();

			while (true)
			{
				int32 waitTime = 1;
				SDL.Event event;


				while (SDL.PollEvent(out event) != 0)
				{
					switch (event.type)
					{
					case .Quit:
						quit();
						return;
					case .KeyDown:
						Key(event.key);
						break;
					case .KeyUp:
						Key(event.key);
						break;
					case .MouseButtonDown:
						Mouse(event.button);
						break;
					case .MouseButtonUp:
						Mouse(event.button);
						break;
					case .MouseMotion:
						MouseMove(event);
						break;
					case .MouseWheel:
						MouseScroll(event);
						break;
					default:
						break;
					}

					HandleEvent(event);

					waitTime = 0;
				}

				// Fixed 60 Hz update
				double msPerTick = 1000 / 60.0;
				int newPhysTickCount = (int)(sw.ElapsedMilliseconds / msPerTick);

				int addTicks = newPhysTickCount - curPhysTickCount;
				keyboardState = SDL.GetKeyboardState(null);

				addTicks = Math.Min(addTicks, 20);// Limit catchup
				if (addTicks > 0)
				{
					for (int i < addTicks)
					{
						updateCnt++;
						update();
					}
					Paint();
				}
				else
				{
					Thread.Sleep(1);
				}

				curPhysTickCount = newPhysTickCount;
			}
		}

		void Paint()
		{
			paint();
			SDL.Rect* r = scope SDL.Rect();
			bool doPaint=false;
			while (true)
			{
				Texture t = parent.GetTexture();
				if (t==null) break;
				t.ToSDLRect(r);
				if (t.Rotate) {
					SDL.RenderCopyEx(renderer, t.Texture,null,r,180,null,0);
				} else {
					SDL.RenderCopy(renderer, t.Texture, null, r);
				}
				doPaint=true;
			}
			if (doPaint) SDL.RenderPresent(renderer);
		}


		void Key(SDL.KeyboardEvent evt)
		{
			keyevent.Code = (KeyCode)evt.keysym.sym;
			keyevent.Scan = (ScanCode)evt.keysym.scancode;
			keyevent.IsRepeat = (evt.isRepeat == 0) ? false : true;
			//String s = scope String();
			//keyevent.Code.ToString(s);
			keyevent.Char = (char32)evt.keysym.sym;

			keyevent.Flags = 0;
			SDL.KeyMod keymod = SDL.GetModState();
			if (keymod.HasFlag(.ALT)) keyevent.Flags += 1;
			if (keymod.HasFlag(.CTRL)) keyevent.Flags += 2;
			if (keymod.HasFlag(.SHIFT)) keyevent.Flags += 4;

			switch (evt.type)
			{
			case .KeyDown:
				keyevent.Event = .KeyDown;
				keydown(keyevent);
				break;
			case .KeyUp:
				keyevent.Event = .KeyUp;
				keyup(keyevent);
				break;
			default:
				break;
			}
		}

		void Mouse(SDL.MouseButtonEvent evt)
		{
			mouseevent.Position.X = evt.x;
			mouseevent.Position.Y = evt.y;
			mouseevent.IsDoubleClick = (evt.clicks == 1) ? false : true;
			mouseevent.Pressed = (MouseEvent.Button)evt.which;

			switch (evt.type)
			{
			case .MouseButtonDown:
				mouseevent.Event = .MouseDown;
				mousedown(mouseevent);
				break;
			case .MouseButtonUp:
				mouseevent.Event = .MouseUp;
				mouseup(mouseevent);
				break;
			default:
				break;
			}
		}

		void MouseMove(SDL.Event evt)
		{
			mouseevent.Position.X = evt.motion.x;
			mouseevent.Position.Y = evt.motion.y;
			mouseevent.Delta.X = evt.motion.xrel;
			mouseevent.Delta.Y = evt.motion.yrel;

			mouseevent.Event = .MouseMove;
			mousemove(mouseevent);
		}

		void MouseScroll(SDL.Event evt)
		{
			mouseevent.Delta.X = evt.wheel.x;
			mouseevent.Delta.Y = evt.wheel.y;

			mouseevent.Event = .MouseScroll;
			mousescroll(mouseevent);
		}

		void HandleEvent(SDL.Event evt)
		{
			event.Event = .Unknown;
			genericevent(event);
		}

		void CreateIcons() {
			SDL.Surface* images;
			images = SDL.SDL_LoadBMP(@"UI.bmp");
			if (images != null) {
	
				int32 size = 20;
			
				SDL.Rect source = SDL.Rect();
				source.w = size;
				source.h = size;
				SDL.Rect dest = SDL.Rect();
				dest.x =0;
				dest.y=0;
				dest.w = size;
				dest.h = size;
				for (int32 i = 0; i < (int32)Forms.Theme.ImageIdx.COUNT; i++)
				{
			    	iconsS[i] = SDL.CreateRGBSurface(0, size, size, 32, rmask, gmask, bmask, amask);
					source.x = (i % 20) * size;
					source.y = (i / 20) * size;
					SDL.SDL_BlitSurface(images, &source, iconsS[i], &dest);
					//iconsT[i] = SDL.CreateTextureFromSurface(renderer, iconsS[i]);
				}
/*			} else {
				char8* err = SDL.GetError();
				String s = new String(err);
				StringView sv = StringView(err);
*/
			}
			SDL.FreeSurface(images);
		}

		public class Texture
		{
			public Rect Rect;
			public SDL.Texture* Texture;
			public bool Rotate=false;

			public this(Rect rect)
			{
				Rect = rect;
			}

			public ~this() {
				if (Texture != null) SDL.DestroyTexture(Texture);
			}

			public void Create(SDL2 g) {
				Texture = SDL.CreateTexture(g.renderer, SDL.PIXELFORMAT_ARGB8888,(int32)SDL.TextureAccess.Target,Rect.Size.Width, Rect.Size.Height);
			}

			public void FillColor(SDL2 g, Color c) {
				Create(g);
				SDL.SetRenderTarget(g.renderer, Texture);
				SDL.SetRenderDrawColor(g.renderer, c.R, c.G, c.B, c.A);
				SDL.Rect* r= scope SDL.Rect();
				ToSDLRect(r);
				r.x=0;
				r.y=0;
				SDL.RenderFillRect(g.renderer, r);
				SDL.SetRenderTarget(g.renderer, null);
			}

			public void FillText(SDL2 g, String text, Mince.Core.Font font) {
				String fullName = font.FullName(.. scope String());
				SDLTTF.Font * sdlfont = SDLTTF.OpenFont(fullName, font.Size);
				SDL.Color color = SDL.Color( font.Color.R, font.Color.G, font.Color.B, font.Color.A );
				SDL.Surface * surface = SDLTTF.RenderText_Solid(sdlfont,text, color); 
				Texture = SDL.CreateTextureFromSurface(g.renderer, surface);
				uint32 format=0;
				int32 access =0;
				SDL.QueryTexture(Texture, out format, out access, out Rect.Size.Width, out Rect.Size.Height);
				SDLTTF.CloseFont(sdlfont);
				SDL.FreeSurface(surface);
			}

			public void DrawFrame(SDL2 g, Color c, int32 width) {
				SDL.Rect[] rects = scope SDL.Rect[4];
				rects[0] = SDL.Rect(0,0,Rect.Size.Width, width);
				rects[1] = SDL.Rect(0,0,width,Rect.Size.Height);
				rects[2] = SDL.Rect(Rect.Size.Width-width, 0, width, Rect.Size.Height);
				rects[3] = SDL.Rect(0, Rect.Size.Height-width, Rect.Size.Width, width);
				SDL.SetRenderTarget(g.renderer, Texture);
				SDL.SetRenderDrawColor(g.renderer, c.R, c.G, c.B, c.A);
				//SDL.RenderFillRects(g.renderer, (SDL.Rect**)&rects,4);
				SDL.RenderFillRect(g.renderer, &rects[0]);
				SDL.RenderFillRect(g.renderer, &rects[1]);
				SDL.RenderFillRect(g.renderer, &rects[2]);
				SDL.RenderFillRect(g.renderer, &rects[3]);
				SDL.SetRenderTarget(g.renderer, null);
			}

			public void FillImage(SDL2 g, String name) {
				SDL.Surface* image;
				image = SDL.SDL_LoadBMP(name);
				if (image != null) {
					SDL.Surface* surface = SDL.CreateRGBSurface(0, Rect.Size.Width, Rect.Size.Height, 32,g.rmask, g.gmask, g.bmask, g.amask);
					SDL.SDL_BlitScaled(image, null, surface, null);
					Texture = SDL.CreateTextureFromSurface(g.renderer, surface);
					SDL.FreeSurface(surface);
				}
				SDL.FreeSurface(image);
			}

			public void FillImage(SDL2 g, int32 ix) {
				SDL.Surface* surface = SDL.CreateRGBSurface(0, Rect.Size.Width, Rect.Size.Height, 32,g.rmask, g.gmask, g.bmask, g.amask);
				SDL.SDL_BlitScaled(g.iconsS[ix], null, surface, null);
				Texture = SDL.CreateTextureFromSurface(g.renderer, surface);
				SDL.FreeSurface(surface);
			}

			public void ToSDLRect(SDL.Rect* r)
			{
				r.x = Rect.Position.X;
				r.y = Rect.Position.Y;
				r.w = Rect.Size.Width;
				r.h = Rect.Size.Height;
			}
		}
	}
}

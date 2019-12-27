module uim.vue.apps.app;

import uim.vue;

class DVUEApp : DH5App {
	this() { super(); }
	this(string aName) { this().name(aName); }
	this(string aName, string aRootPath) { this().name(aName).rootPath(aRootPath); }

	O imports(this O)(DVUEComponent aComponent)	{ components(aComponent); return cast(O) this; }
	O imports(this O)(DVUEMixin aMixin) { mixins(aMixin); return cast(O) this; }
	O imports(this O)(DVUEModule aModule) { modules(aModule); return cast(O) this; }

	private DVUEComponent[string] _components;
	auto components() { return _components; }
	O components(this O)(DVUEComponent newComponent) { this.components(newComponent.app(this).name, newComponent); return cast(O) this; }
	O components(this O)(string name, string newComponent) { return this.components(name, VUEComponent(this).content(newComponent)); }
	O components(this O)(string name, DVUEComponent newComponent) {
		newComponent.app(this);
		_components[name] = newComponent;
		return cast(O) this;
	}

	private DVUEMixin[string] _mixins;
	auto mixins() { return _mixins; }
	O mixins(this O)(string[string] newMixins) { foreach(name, mix; newMixins) this.mixins(name, VUEMixin(this).content(mix)); return cast(O)this; }
	O mixins(this O)(DVUEMixin[string] newMixins) { foreach(name, mix; newMixins) this.mixins(name, VUEMixin(this).content(mix)); return cast(O)this; }
	O mixins(this O)(string name, string newMixin) { return this.mixins(name, VUEMixin(this).content(newMixin)); }
	O mixins(this O)(string name, DVUEMixin newMixin) {
		newMixin.app(this);
		_mixins[name] = newMixin;
		return cast(O) this;
	}
	unittest {
		/// TODO
	}

	DVUEModule[string] _modules;
	auto modules() { return _modules; }
	O modules(this O)(string[string] newModules) { foreach(name, mod; newModules) this.modules(name, VUEModule(this).content(mod)); return cast(O)this; }
	O modules(this O)(DVUEModule[string] newModules) { foreach(name, mod; newModules) this.modules(name, VUEModule(this).content(mod)); return cast(O)this; }
	O modules(this O)(string name, string newModule) { return this.modules(name, VUEModule(this).content(newnewModuleontent)); }
	O modules(this O)(string name, DVUEModule newModule) {
		newModule.app(this);
		_modules[name] = newModule;
		return cast(O) this;
	}
	unittest {
	/// TODO
	}

	/// Central request handler
	override void request(HTTPServerRequest req, HTTPServerResponse res) {
		writeln("VUEApp");
		/// Extract appPath from URL path
	  auto appPath = req.path.replace(_rootPath, "");
		auto pathItems = appPath.split("/");

		super.request(req, res);

		writeln("VUEApp");
		if (pathItems.length == 0) { _index.request(req, res); }
		else {
			switch(pathItems[0]) {				
				case "index":
				case "start": _index.request(req, res); break;
				case "css": 
					if (name in _styles) _styles[name].request(req, res);
					break;
				case "img": 
					if (name in _images) _images[name].request(req, res);
					break;
				case "js": 
					if (name in _scripts) _scripts[name].request(req, res);
					break;
				case "start.js":
				case "main.js":
				case "index.js":
					string importApp = `import App from './component/App.js'; new Vue({ render: h => h(App) }).$mount('#app');`;
					auto appName = req.query.get("app", null);
					if (appName)
						VUEMain.content(
								`import App from './component/%s.js'; new Vue({ render: h => h(App) }).$mount('#app');`.format(appName))
							.request(req, res);
					else
						VUEMain.content(importApp).request(req, res);
					break;
				default: 
					break;
			}
		}
	/*
		}
		if (pathItems.length == 2) {
			auto type = pathItems[0];
			// debug writeln("[IN APP] My type is ", type);
			auto name = pathItems[1];
			// debug writeln("[IN APP] My path is ", name);
			switch (type)
			{
			case "component":
				if (name in _components)
					_components[name].request(req, res);
				break;
			case "css":
				break;
			case "img":
				break;
			case "js":
				break;
			case "mixin":
				if (name in _mixins)
					_mixins[name].request(req, res);
				break;
			case "module":
				if (name in _modules)
					_modules[name].request(req, res);
				break;
			case "page":
				// debug writeln("It's a page");
				if (name in _pages)
					_pages[name].request(req, res);
				break;
			default:
				break;
			}
		}*/
	}
}
auto VUEApp() { return new DVUEApp(); }
auto VUEApp(string aName) { return new DVUEApp(aName); }
auto VUEApp(string aName, string aRootPath) { return new DVUEApp(aName, aRootPath); }

unittest {
}



module uim.vue.app;

import uim.vue;

class DVUEApp : DVueObj {
	this() { super(); }
	this(string name, string someContent) { super(name); _content = someContent; }

	mixin(TProperty!("string", "rootPath"));

	mixin(TProperty!("string", "content"));

	O imports(this O)(DVUEComponent aComponent) { components(aComponent); return cast(O)this; }
	O imports(this O)(DVUEMixin aMixin) { mixins(aMixin); return cast(O)this; }
	O imports(this O)(DVUEModule aModule) { modules(aModule); return cast(O)this; }

	private DVUEComponent[string] _components;
	O components(this O)(DVUEComponent newComponent) { newComponent.app(this); this.components(newComponent.name, newComponent); return cast(O)this; }
	O components(this O)(string name, DVUEComponent newComponent) { newComponent.app(this); _components[name] = newComponent; return cast(O)this; }
	O components(this O)(string name, string newComponent) { _components[name] = VUEComponent(this).content(newComponent); return cast(O)this; }

	private DVUEMixin[string] _mixins;
	O mixins(this O)(string name, DVUEMixin newMixin) { newMixin.app(this); _mixins[name] = newMixin; return cast(O)this; }
	O mixins(this O)(string name, string newMixin) { _mixins[name] = VUEMixin(this).content(newMixin); return cast(O)this; }

	DVUEModule[string] _modules;
	O modules(this O)(string name, DVUEModule newModule) { newModule.app(this); _modules[name] = newModule; return cast(O)this; }
	O modules(this O)(string name, string newModule) { _modules[name] = VUEModule(this).content(newnewModuleontent); return cast(O)this; }

	mixin(TProperty!("DVUEIndex", "index"));
	O index(this O)(string newContent) { _index = VUEIndex.content(newContent); return cast(O)this; }
	O index(this O)(string newContent, string function(string, string[string]) func, string[string] someParameters = null) { _index = VUEIndex.content(newContent).layout(func).parameters(someParameters); return cast(O)this; }
	
	mixin(TProperty!("DVUEMain", "start"));
	O start(this O)(string newContent) { _start = VUEMain.content(newContent); return cast(O)this; }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		auto path = req.path.replace(_rootPath, "");
		auto pathItems = path.split("/");

		writeln("path: ", path);
		writeln("Components: ", _components);
		if (pathItems.length > 0) {
			switch(pathItems[0]) {				
				case "index":
				case "index.html": _index.request(req, res); break;
				case "start":
				case "start.js": 
				case "main":
				case "main.js": _start.request(req, res); break;
				default: 
					if (pathItems.length > 1) {
						auto type = pathItems[0];
						auto name = pathItems[1..$].join("/").replace(".js", "");
						switch(type) {
							case "component": if (name in _components) _components[name].request(req, res); break;
							case "mixin": if (name in _mixins) _mixins[name].request(req, res); break;
							case "module": if (name in _modules) _modules[name].request(req, res); break;
							default: break;
						}
					}
				break;
			}
		}
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto VUEApp() { return new DVUEApp(); }

unittest {
}
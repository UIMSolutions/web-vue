module uim.vue.app;

import uim.vue;

class DVUEApp : DVueObj {
	this() { super(); }
	this(string name, string someContent) { super(name); _content = someContent; }

	mixin(TProperty!("string", "rootPath"));
	mixin(TProperty!("string", "content"));
	mixin(TProperty!("DVUEComponent[string]", "components"));
	O component(this O)(string name, string newContent) { _components[name] = VUEComponent.content(newContent); return cast(O)this; }

	mixin(TProperty!("DVUEIndex", "index"));
	O index(this O)(string newContent) { _index = VUEIndex.content(newContent); return cast(O)this; }
	
	mixin(TProperty!("DVUEMain", "start"));
	O start(this O)(string newContent) { _start = VUEMain.content(newContent); return cast(O)this; }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		auto path = req.path.replace(_rootPath, "");
		auto pathItems = path.split("/");

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
						auto name = pathItems[1..$].join("/");
						switch(type) {
							case "component": if (name in _components) _components[name].request(req, res); break;
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
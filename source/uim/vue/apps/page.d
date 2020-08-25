module uim.vue.apps.page;

import uim.vue;

class DVUEPage : DH5AppPage {
	this() { super(); }
	this(DVUEApp anApp) { this().app(anApp); }
	this(string aName) { this().name(aName); }
	this(DVUEApp anApp, string aName) { this(anApp).name(aName); }

	DVUEInstance _instance;
	auto instance() { return _instance; }
	O instance(this O)(DVUEInstance newInstance) { _instance = newInstance; return cast(O)this; }
	unittest {

	}

	DVuex _store;
	auto store() { return _store; }
	O store(this O)(DVUEInstance newStore) { _store = newStore; return cast(O)this; }
	unittest {
		
	}

	string[string] _components;
	auto components() { return _components; }
	O clearComponents(this O)() { _components = null; return cast(O)this; }
	O components(this O)(string name, string value) { _components[name] = value; return cast(O)this; }
	O components(this O)(string[string] values) { foreach(k, v; values) _components[k] = v; return cast(O)this; }
	unittest {
		/// TODO
	}

	override void request(HTTPServerRequest req, HTTPServerResponse res, string[string] parameters = null) {
    parameters["vueApp"] = VUEInstance("app").toString;
    // parameters["jsStart"] = UIMIconbarHorizontal.toVUEComponent.globalRegistration;

		super.request(req, res);
  }
}
auto VUEPage() { return new DVUEPage; }
auto VUEPage(string aName) { return new DVUEPage(aName); }
auto VUEPage(DVUEApp anApp) { return new DVUEPage(anApp); }
auto VUEPage(DVUEApp anApp, string aName) { return new DVUEPage(anApp, aName); }

///
unittest {
}


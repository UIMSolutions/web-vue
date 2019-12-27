module uim.vue.apps.index;

import uim.vue;

class DVUEIndex : DVUEPage {
		this() { super(); }
	this(DVUEApp anApp) { this().app(anApp); }
	this(string aName) { this().name(aName); }
	this(DVUEApp anApp, string aName) { this(anApp).name(aName); }
}
auto VUEIndex() { return new DVUEIndex; }
auto VUEIndex(string aName) { return new DVUEIndex(aName); }
auto VUEIndex(DVUEApp anApp) { return new DVUEIndex(anApp); }
auto VUEIndex(DVUEApp anApp, string aName) { return new DVUEIndex(anApp, aName); }

unittest {
	/// TODO
}


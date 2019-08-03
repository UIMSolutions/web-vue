module uim.vue.index;

import uim.vue;

class DVUEIndex {
	this() {}

	string function(string, string[string]) _layout;
	@property layout(this O)(string function(string, string[string]) func) { _layout = func; return cast(O)this; }

	mixin(TProperty!("string", "content"));
	mixin(TProperty!("string[string]", "components"));

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		if (_layout) res.writeBody(_layout(toString, null), "text/html");
		else res.writeBody(toString, "text/html");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto VUEIndex() { return new DVUEIndex; }

unittest {
}


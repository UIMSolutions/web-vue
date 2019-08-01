module uim.vue.index;

import uim.vue;

class DVUEIndex {
	this() {}

	mixin(TProperty!("string", "content"));
	mixin(TProperty!("string[string]", "components"));

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/html");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto VUEIndex() { return new DVUEIndex; }

unittest {
	writeln("Testing ", __MODULE__);
}


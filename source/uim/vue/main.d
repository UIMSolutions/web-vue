module uim.vue.main;

import uim.vue;

class DVUEMain {
	this() {
	}

	mixin(TProperty!("string", "content"));
	mixin(TProperty!("string[string]", "components"));

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}
	override string toString() {
		return (_content) ? _content : "";
	}
}
auto VUEMain() { return new DVUEMain; }

unittest {
	writeln("Testing ", __MODULE__);
}


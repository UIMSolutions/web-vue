module uim.vue.module_;

import uim.vue; 

class DVUEModule {
	this() {
	}

	mixin(TProperty!("string[]", "imports"));
	O imports(this O)(string text) { _imports ~= "import "~text; return cast(O)this; }

	mixin(TProperty!("string[string]", "exports"));
	O exports(this O)(string text) { _exports["default"] = text; return cast(O)this; }
	O exports(this O)(string name, string text) { _exports[name] = text; return cast(O)this; }

	mixin(TProperty!("string", "content"));
	O content(this O)(DJS js) { _content = js.toString; return cast(O)this; }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toJS, "text/javascript");
	}
	string toJS() {
		if (!_content) {
			string result;
			if (imports) result ~= imports.join("");
			foreach(k, v; exports) result ~= "export %s{%s}".format(k, v);
			_content = result;
		}
		return _content;
	}
}
auto VUEModule() { return new DVUEModule(); }

unittest {

}
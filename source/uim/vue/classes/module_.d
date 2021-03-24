module uim.vue.classes.module_;

import uim.vue;

@safe: 

class DVUEModul_ : DJSModule {
	this() { super(); }
	this(DVUEApp anApp) { this(); _app = anApp; }
	this(string aName) { this(); _name = aName; }
	this(DVUEApp anApp, string aName) { this(anApp); _name = aName; }

	// App which uses this module
	mixin(TProperty!("DVUEApp", "app"));

	// Name of module
	mixin(TProperty!("string", "name"));
	unittest {
		assert(VUEModul_.name("test").name == "test");
		assert(VUEModul_("test").name == "test");
	}

	// Path
	mixin(TProperty!("string", "path"));
	unittest {
		assert(VUEModul_.path("/module/test.js").path == "/module/test.js");
	}

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}
}
auto VUEModul_() { return new DVUEModul_(); }
auto VUEModul_(string aName) { return new DVUEModul_(aName); }
auto VUEModul_(DVUEApp anApp) { return new DVUEModul_(anApp); }
auto VUEModul_(DVUEApp anApp, string aName) { return new DVUEModul_(anApp, aName); }

unittest {
	assert(VUEModul_.imports(["name":"file.js"]) == "import name from 'file.js';");
	assert(VUEModul_.imports(["name from 'file.js'", "othername from 'otherfile.js'"]) == "import name from 'file.js';import othername from 'otherfile.js';");

	assert(VUEModul_.imports("name", "file.js") == "import name from 'file.js';");
	assert(VUEModul_.imports("name from 'file.js'") == "import name from 'file.js';");

	assert(VUEModul_.exportsDefault("{ var a = 1; }") == "export default { var a = 1; };");
	assert(VUEModul_.exports(["const foo = Math.sqrt(2)"]) == "export const foo = Math.sqrt(2);");
	assert(VUEModul_.exports("const foo = Math.sqrt(2)") == "export const foo = Math.sqrt(2);");
}
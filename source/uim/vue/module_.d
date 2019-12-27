module uim.vue.module_;

import uim.vue; 

class DVUEModule : DJSModule {
	this() { super(); }
	this(DVUEApp anApp) { this(); _app = anApp; }
	this(string aName) { this(); _name = aName; }
	this(DVUEApp anApp, string aName) { this(anApp); _name = aName; }

	// App which uses this module
	mixin(TProperty!("DVUEApp", "app"));

	// Name of module
	mixin(TProperty!("string", "name"));
	unittest {
		assert(VUEModule.name("test").name == "test");
		assert(VUEModule("test").name == "test");
	}

	// Path
	mixin(TProperty!("string", "path"));
	unittest {
		assert(VUEModule.path("/module/test.js").path == "/module/test.js");
	}

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}
}
auto VUEModule() { return new DVUEModule(); }
auto VUEModule(string aName) { return new DVUEModule(aName); }
auto VUEModule(DVUEApp anApp) { return new DVUEModule(anApp); }
auto VUEModule(DVUEApp anApp, string aName) { return new DVUEModule(anApp, aName); }

unittest {
	assert(VUEModule.imports(["name":"file.js"]) == "import name from 'file.js';");
	assert(VUEModule.imports(["name from 'file.js'", "othername from 'otherfile.js'"]) == "import name from 'file.js';import othername from 'otherfile.js';");

	assert(VUEModule.imports("name", "file.js") == "import name from 'file.js';");
	assert(VUEModule.imports("name from 'file.js'") == "import name from 'file.js';");

	assert(VUEModule.exportsDefault("{ var a = 1; }") == "export default { var a = 1; };");
	assert(VUEModule.exports(["const foo = Math.sqrt(2)"]) == "export const foo = Math.sqrt(2);");
	assert(VUEModule.exports("const foo = Math.sqrt(2)") == "export const foo = Math.sqrt(2);");
}
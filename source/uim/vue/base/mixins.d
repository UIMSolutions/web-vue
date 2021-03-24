module uim.vue.base.mixins;

import uim.vue;

@safe:

class DVUEMixin : DVUEObj {
	this() { super(); }
	this(DVUEApp anApp) { this(); _app = anApp; }
	this(string aName) { this(); _name = aName; }
	this(DVUEApp anApp, string aName) { this(anApp); _name = aName; }

	mixin(TProperty!("DVUEApp", "app"));

	private string[] _imports;
	O imports(this O)(string[string] someImports) { foreach(k, v; someImports) this.imports(k, v); return cast(O)this; }
	O imports(this O)(string anName, string fromFile) { this.imports(anName~" from '"~fromFile~"'"); return cast(O)this; }
	O imports(this O)(string[] someImports) { foreach(imp; someImports) this.imports(imp); return cast(O)this; }
	O imports(this O)(string anImport) { _imports ~= "import "~anImport~";"; return cast(O)this; }
	unittest {
		assert(VUEMixin.imports(["name":"file.js"]) == "import name from 'file.js';");
		assert(VUEMixin.imports(["name from 'file.js'", "othername from 'otherfile.js'"]) == "import name from 'file.js';import othername from 'otherfile.js';");

		assert(VUEMixin.imports("name", "file.js") == "import name from 'file.js';");
		assert(VUEMixin.imports("name from 'file.js'") == "import name from 'file.js';");
	}

	private string[] _exports;
	O exportsDefault(this O)(DJS anExport) { this.exportsDefault(anExport.toString); return cast(O)this; }
	O exportsDefault(this O)(string anExport) { this.exports("default "~anExport); return cast(O)this; }
	O exports(this O)(DJS[] someExport) { foreach(ex; someExports) this.exports(ex); return cast(O)this; }
	O exports(this O)(string[] anExport) { foreach(ex; someExports) this.exports(ex); return cast(O)this; }
	O exports(this O)(DJS anExport) { this.exports(anExport.toString); return cast(O)this; }
	O exports(this O)(string anExport) { _exports ~= "export "~anExport~";"; return cast(O)this; }
	unittest {
		assert(VUEMixin.exports("const foo = Math.sqrt(2)") == "export const foo = Math.sqrt(2);");
	}

	mixin(TProperty!("string", "content"));
	O content(this O)(DJS js) { _content = js.toString; return cast(O)this; }

	override bool opEquals(string txt) { return (txt == toString); }

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toJS, "text/javascript");
	}
	string toJS() {
		string result;
		result = toString;
		return result;
	}
	override string toString() {
		string result;
		result ~= _imports.join("");
		result ~= _exports.join("");
		return result;
	}
}
auto VUEMixin() { return new DVUEMixin(); }
auto VUEMixin(string aName) { return new DVUEMixin(aName); }
auto VUEMixin(DVUEApp anApp) { return new DVUEMixin(anApp); }
auto VUEMixin(DVUEApp anApp, string aName) { return new DVUEMixin(anApp, aName); }

unittest {

}
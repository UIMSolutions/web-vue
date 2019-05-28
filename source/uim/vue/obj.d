module uim.vue.obj;

import uim.vue;

class DVUEObj {
	this() {}
	this(string aName) { this; _name = aName; }

	mixin(TProperty!("string", "name"));

	mixin(TPropertyAA!("string", "string", "data"));
	O data(string name, string value) { _data[name] = value; return cast(O)this; }
	O data(string name, T value) { _data[name] = to!string(value); return cast(O)this; }

	mixin(TPropertyAA!("string", "string", "filters"));
	O filter(string name, string value) { _filters[name] = value; return cast(O)this; }

	mixin(TPropertyAA!("string", "string", "methods"));
	O method(string name, string value) { _methods[name] = value; return cast(O)this; }

	mixin(TPropertyAA!("string", "string", "computed"));
	O computed(string name, string value) { _computed[name] = value; return cast(O)this; }

	mixin(TPropertyAA!("string", "string", "watch"));
	O watch(string name, string value) { _watch[name] = value; return cast(O)this; }

	override string toString() { return ""; }
}
auto VUEObj() { return new DVUEObj(); }

unittest {
	writeln("Testing ", __MODULE__);
}

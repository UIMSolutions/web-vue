module uim.vue.obj;

import uim.vue;

class DVUEObj {
	this() {}

	mixin(TProperty!("string", "name"));
	mixin(TPropertyAA!("string", "string", "data"));
	mixin(TPropertyAA!("string", "string", "filters"));
	mixin(TPropertyAA!("string", "string", "methods"));
	mixin(TPropertyAA!("string", "string", "computed"));
	mixin(TPropertyAA!("string", "string", "watch"));

	override string toString() {
		return "";
	}
}
auto VUEObj() { return new DVUEObj(); }

unittest {
	writeln("Testing ", __MODULE__);
}

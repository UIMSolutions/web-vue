module uim.vue.content;

import uim.vue;

class DVUEContent {
/*
	this() {
		root = H5DIV;
		app = new DVUEInstance;
	}

	mixin(TProperty!("string", "name", "\"app\""));
	mixin(TProperty!("DH5DIV", "root"));
	mixin(TProperty!("DVUEInstance", "app"));

	override string toString() {
		string result;

		result = root.id(name).toString;
		result ~= H5SCRIPT(app.toString).toString;

		return result;
	}
	*/
}
auto VUEContent() { return new DVUEContent; }

unittest {
	writeln("Testing ", __MODULE__);
}


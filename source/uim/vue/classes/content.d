module uim.vue.content;

import uim.vue;

@safe:

class DVUEContent {
	this() {
		root = H5Div;
		app = new DVUEInstance;
	}

	mixin(TProperty!("string", "name", "\"app\""));
	mixin(TProperty!("DH5Div", "root"));
	mixin(TProperty!("DVUEInstance", "app"));

	override string toString() {
		string result;

		result = root.id(name).toString;
		result ~= H5Script(app.toString).toString;

		return result;
	}
}
auto VUEContent() { return new DVUEContent; }

unittest {
	
}


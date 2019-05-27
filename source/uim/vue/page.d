module uim.vue.page;

import uim.vue;

class DVUEPage {
	mixin(TProperty!("DVUEContent[]", "contents"));

	override string toString() {
		string result;
		foreach(content; contents) {
			result ~= content.toString;
		}
		return result;
	}
}
auto VUEPage() { return new DVUEPage; }

unittest {
	writeln("Testing ", __MODULE__);
}


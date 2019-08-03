module uim.vue.obj;

import uim.vue;

class DVueObj {
	this() {}
	this(string aName) { this(); _name = aName; }

	mixin(TProperty!("string", "name"));
	unittest {
		assert(VueObj.name("test").name == "test");
		assert(VueObj("test").name == "test");
	}

	mixin(TPropertyAA!("string", "string", "data"));
	unittest {
		assert(VueObj.data(["a":"b"]).data == ["a":"b"]);
		assert(VueObj.data("a", "b").data == ["a":"b"]);
	}

	mixin(TPropertyAA!("string", "string", "filters"));
	unittest {
		assert(VueObj.filters(["a":"b"]).filters == ["a":"b"]);
		assert(VueObj.filters("a", "b").filters == ["a":"b"]);
	}

	mixin(TPropertyAA!("string", "string", "methods"));
	unittest {
		assert(VueObj.methods(["a":"b"]).methods == ["a":"b"]);
		assert(VueObj.methods("a", "b").methods == ["a":"b"]);
	}

	mixin(TPropertyAA!("string", "string", "computed"));
	O computed(this O)(string name, DJS txt) { _computed[name] = txt.toString; return cast(O)this; }	
	unittest {
		assert(VueObj.computed("a","b").computed == ["a":"b"]);
	}

	mixin(TPropertyAA!("string", "string", "watch"));
	unittest {
		assert(VueObj.watch(["a":"b"]).watch == ["a":"b"]);
	}
	bool opEqual(string txt) { return toString == txt; }
	override string toString() { return ""; }
}
auto VueObj() { return new DVueObj(); }
auto VueObj(string aName) { return new DVueObj(aName); }


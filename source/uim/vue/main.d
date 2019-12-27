module uim.vue.main;

import uim.vue;

class DVUEMain {
	this() {
	}

	mixin(XPropertyString!("content"));
	unittest {
//		assert(VUEMain.)	
	}

	/// A hash of components to be made available to the Vue instance.
	mixin(XPropertyAA!"components"); 
	unittest {
		assert(VUEMain.components("a","b").components == ["a":"b"]);
		assert(VUEMain.components("a","b").components == ["a":"b"]);
		assert(VUEMain.components("a","b").components("x","y").components == ["a":"b", "x":"y"]);
		assert(VUEMain.components("a","b").components("x","y").removeComponents("a").components == ["x":"y"]);
		assert(VUEMain.components("a","b").components("a","y").components == ["a":"y"]);
		// assert(VUEMain.components("a","b").clearComponents.components == null);
	}

	void request(HTTPServerRequest req, HTTPServerResponse res) {		
		res.writeBody(toString, "text/javascript");
	}

		/// Compare 
	bool opEquals(string txt) { return toString == txt; }
	unittest{
		assert(VUEMain == VUEMain.toString);
	}

	override string toString() {
		return (_content) ? _content : "";
	}
}
auto VUEMain() { return new DVUEMain; }
unittest {
	assert(VUEMain == "");
}


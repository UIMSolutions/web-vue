module uim.vue.base.obj;

import uim.vue;

class DVUEObj {
	this() {}
	this(string aName) { this(); _name = aName; }

	mixin(TProperty!("string", "name"));
	unittest {
		assert(VUEObj.name("test").name == "test");
		assert(VUEObj("test").name == "test");
	}

	
	/// Data object for the Vue instance or component
	mixin(XStringAA!"data"); 
	O data(this O)(string name) { return data(name, name); }
	unittest {
		assert(VUEObj.data("a","b").data == ["a":"b"]);
		assert(VUEObj.data("a","b").data == ["a":"b"]);
		assert(VUEObj.data("a","b").data("x","y").data == ["a":"b", "x":"y"]);
		// assert(VUEObj.data("a","b").data("x","y").removeData("a").data == ["x":"y"]);
		assert(VUEObj.data("a","b").data("a","y").data == ["a":"y"]);
		// assert(VUEObj.data("a","b").clearData.data == null);
	}
	unittest {
		/// TODO
	}
	
	mixin(XStringAA!"methods");
	unittest {
		assert(VUEObj.methods("a","b").methods == ["a":"b"]);
		assert(VUEObj.methods("a","b").methods == ["a":"b"]);
		assert(VUEObj.methods("a","b").methods("x","y").methods == ["a":"b", "x":"y"]);
		assert(VUEObj.methods("a","b").methods("x","y").removeMethods("a").methods == ["x":"y"]);
		assert(VUEObj.methods("a","b").methods("a","y").methods == ["a":"y"]);
		// assert(VUEObj.methods("a","b").clearMethods.methods == null);
	}
	unittest {
		/// TODO
	}

	string[string] _computed;
	auto computed() { return _computed; }
	O computed(this O)(string[string] contents) { foreach(name,value; contents) _computed[name] = "function(){"~value~"}"; return cast(O)this; }
	O computed(this O)(string name, string content) { _computed[name] = "function(){"~content~"}"; return cast(O)this; }
	O computed(this O)(string name, string getContent, string setContent) {
		string[] result;
		if (getContent) result ~= "get:function(){"~getContent~"}"; 
		if (setContent) result ~= "set:function(){"~setContent~"}"; 
		_computed[name] = "{"~result.join(",")~"}"; 
		return cast(O)this;
	}
	unittest {
		assert(VUEObj.computed("a","b").computed == ["a":"function(){b}"]);
		assert(VUEObj.computed(["a":"b"]).computed == ["a":"function(){b}"]);
		assert(VUEObj.computed("a","b","c").computed == ["a":"{get:function(){b},set:function(){c}}"]);
		assert(VUEObj.computed("a",null,"c").computed == ["a":"{set:function(){c}}"]);
		assert(VUEObj.computed("a","b",null).computed == ["a":"{get:function(){b}}"]);
		assert(VUEObj.computed("a","b").computed("a","b","c").computed == ["a":"{get:function(){b},set:function(){c}}"]);
	}
	
	mixin(XStringAA!"watch"); 
	unittest {
		/// TODO
	}

	mixin(XString!"template_"); 
	O template_(this O)(DH5Obj h5){ _template_ ~= h5.toString; return cast(O)this; }
	unittest {
		assert(VUEObj.template_("a").template_ == "a");
		assert(VUEObj.template_("a").template_("x").template_ == "ax");
	}

	string[string] settings() {
		string[string] results;

		if (_methods) {
			string[] funcs;
			foreach(k, v; _methods) funcs ~= k~"{"~v~"}";
			results["methods"] = "{"~funcs.sort.join(",")~"}";
		}
		if (_computed) results["computed"] = _computed.toJS(true);
		if (_watch) {
			string[string] _inner;
			foreach(k, v; _watch) _inner[k] = "function(value){"~v~"}";
			results["watch"] = _inner.toJS(true);
		}

		if (_template_) results["template"] = "`"~_template_~"`";

		return results;
	}

	bool opEquals(string txt) { return toString == txt; }
	override string toString() { return ""; }
}
auto VUEObj() { return new DVUEObj(); }
auto VUEObj(string aName) { return new DVUEObj(aName); }
unittest{

}

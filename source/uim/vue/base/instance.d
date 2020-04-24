module uim.vue.base.instance;

import uim.vue;

class DVUEInstance : DVUEObj {
	this() { super(); }
	this(string aName) { super(aName); }

	mixin(TProperty!("string", "variable"));
	unittest {
		assert(VUEInstance == "new Vue();");
		assert(VUEInstance.variable("test").variable == "test");
		assert(VUEInstance("xyz") == "new Vue({el:'#xyz'});");
		assert(VUEInstance("xyz").variable("test") == "var test=new Vue({el:'#xyz'});");
	}

	/// A hash of components to be made available to the Vue instance.
	mixin(XStringAA!"components"); 
	unittest {
		assert(VUEInstance.components("a","b").components == ["a":"b"]);
		assert(VUEInstance.components(["a":"b"]).components == ["a":"b"]);
		assert(VUEInstance.components(["a":"b"]).components("x","y").components == ["a":"b", "x":"y"]);
		/// TODO assert(VUEInstance.components("a","b").components("x","y").removeComponents("a").components == ["x":"y"]);
		assert(VUEInstance.components(["a":"b"]).components("a","y").components == ["a":"y"]);
		assert(VUEInstance.components("a","b").clearComponents.components == null);
	}

	/**
	* filter - A hash of filters to be made available to the Vue instance.
	*/
	mixin(XStringAA!"filters"); 
	unittest {
		assert(VUEInstance.filters("a","b").filters == ["a":"b"]);
		assert(VUEInstance.filters(["a":"b"]).filters == ["a":"b"]);
		assert(VUEInstance.filters(["a":"b"]).filters("x","y").filters == ["a":"b", "x":"y"]);
		/// TODO: assert(VUEInstance.filters("a","b").filters("x","y").removeFilters("a").filters == ["x":"y"]);
		assert(VUEInstance.filters(["a":"b"]).filters("a","y").filters == ["a":"y"]);
		assert(VUEInstance.filters("a","b").clearFilters.filters == null);
	}

	/**
	* hooks - All lifecycle hooks: 
	* beforeCreate, created, beforeMount, mounted, beforeUpdate, updated, activated, deactivated, beforeDestroy, destroyed, errorCaptured
	*/ 
	mixin(XStringAA!"hooks"); 
	unittest {
		assert(VUEInstance.hooks("a","b").hooks == ["a":"b"]);
		assert(VUEInstance.hooks(["a":"b"]).hooks == ["a":"b"]);
		assert(VUEInstance.hooks(["a":"b"]).hooks("x","y").hooks == ["a":"b", "x":"y"]);
		/// TODO assert(VUEInstance.hooks("a","b").hooks("x","y").removeHooks("a").hooks == ["x":"y"]);
		assert(VUEInstance.hooks(["a":"b"]).hooks("a","y").hooks == ["a":"y"]);
		assert(VUEInstance.hooks("a","b").clearHooks.hooks == null);
	}

	/** 
	* plugins - Plugins usually add global-level functionality to Vue. 
	*/
	mixin(XStringArray!"plugins"); 
	unittest {
		assert(VUEInstance.plugins("a").plugins == ["a"]);
		assert(VUEInstance.plugins(["a","b"]).plugins == ["a","b"]);
		assert(VUEInstance.plugins("a").plugins("x").plugins == ["a", "x"]);
		//// TODO assert(VUEInstance.plugins("a").plugins("x").removePlugins("a").plugins == ["x"]);
		assert(VUEInstance.plugins(["a","b"]).clearPlugins.plugins == null);
	}

	override string[string] settings() {
		string[string] results = super.settings;

		if (_name) results["el"] = "'#"~_name~"'";
		if (_data) results["data"] = _data.toJS(true);
		if (_components) results["components"] = _components.toJS;
		if (_filters) results["filters"] = _filters.toJS;
		if (_hooks) results["hooks"] = _hooks.toJS;
		if (_plugins) results["plugins"] = _plugins.toJS;

		return results;
	}

	/// Compare 
	override bool opEquals(string txt) { return toString == txt; }
	unittest{
		assert(VUEInstance == VUEInstance.toString);
	}

	/// Export to string
	override string toString() {
		string result;
		if (_variable) result ~= "var "~variable~"=";
		result ~= "new Vue("~(settings ? settings.toJS(true) : "")~");";
		return result;
	}
}
auto VUEInstance() { return new DVUEInstance(); }
auto VUEInstance(string aName) { return new DVUEInstance(aName); }

unittest {
	assert(VUEInstance == "new Vue();");
	assert(VUEInstance("app") == "new Vue({el:'#app'});");
	assert(VUEInstance.name("app") == "new Vue({el:'#app'});");
	assert(VUEInstance.variable("vue").name("app") == "var vue=new Vue({el:'#app'});");
	assert(VUEInstance.name("app").data("a", "'b'") == "new Vue({data:{a:'b'},el:'#app'});",
	"Wrong? -> "~VUEInstance.name("app").data("a", "'b'").toString);
	assert(VUEInstance.name("app").data("a", "'b'").data(["x": "'y'"]) == "new Vue({data:{a:'b',x:'y'},el:'#app'});",
	"Wrong? -> "~VUEInstance.name("app").data("a", "'b'").data(["x": "'y'"]).toString);
	// Test computed
	assert(VUEInstance.computed("a","return b;") == "new Vue({computed:{a:function(){return b;}}});", 
	"Wrong? -> "~VUEInstance.computed("a","return b;").toString);
	assert(VUEInstance.computed("a","return b;").computed("x","return z;") == "new Vue({computed:{a:function(){return b;},x:function(){return z;}}});", 
	"Wrong? -> "~VUEInstance.computed("a","return b;").computed("x","return z;").toString);
	assert(VUEInstance.computed(["a":"return b;", "x":"return z;"]) == "new Vue({computed:{a:function(){return b;},x:function(){return z;}}});", 
	"Wrong? -> "~VUEInstance.computed(["a":"return b;", "x":"return z;"]).toString);
	// Test methods
	assert(VUEInstance.methods("a()","return b;") == "new Vue({methods:{a(){return b;}}});", 
	"Wrong? -> "~VUEInstance.methods("a()","return b;").toString);
	assert(VUEInstance.methods("a()","return b;").methods("x()","return z;") == "new Vue({methods:{a(){return b;},x(){return z;}}});", 
	"Wrong? -> "~VUEInstance.methods("a()","return b;").methods("x()","return z;").toString);
	assert(VUEInstance.methods(["a()":"return b;", "x()":"return z;"]) == "new Vue({methods:{a(){return b;},x(){return z;}}});", 
	"Wrong? -> "~VUEInstance.methods(["a()":"return b;", "x()":"return z;"]).toString);
	// Test watch
	assert(VUEInstance.watch("a","return value;") == "new Vue({watch:{a:function(value){return value;}}});", 
	"Wrong? -> "~VUEInstance.watch("a","return value;").toString);
	assert(VUEInstance.watch("a","return value;").watch("x","return value;") == "new Vue({watch:{a:function(value){return value;},x:function(value){return value;}}});", 
	"Wrong? -> "~VUEInstance.watch("a","return value;").watch("x","return value;").toString);
	assert(VUEInstance.watch(["a":"return value;", "x":"return value;"]) == "new Vue({watch:{a:function(value){return value;},x:function(value){return value;}}});", 
	"Wrong? -> "~VUEInstance.watch(["a":"return value;", "x":"return value;"]).toString);
}
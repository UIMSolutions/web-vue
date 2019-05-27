module uim.vue.vuex;

import uim.vue;

class DVuex {
	this() {}
	this(string name) { this(); _name = name; }

	mixin(TProperty!("string", "name"));
	mixin(TPropertyAA!("string", "string", "state"));
	O state(this O)(string name, int value) { return this.state(name, to!string(value)); } 
	O state(this O)(string name, Json value) { return this.state(name, value.toString); } 
	O state(this O)(string name, string[] values) {
		return this.state(name, "["~values.join(",")~"]"); 
	} 
	O state(this O)(string name, Json[] values) {
		string[] results;
		foreach(value; values) { results ~= value.toString; }
		return this.state(name, results); 
	} 

	mixin(TPropertyAA!("string", "string", "getters"));
	mixin(TPropertyAA!("string", "string", "mutations"));
	mixin(TPropertyAA!("string", "string", "actions"));
	mixin(TPropertyAA!("string", "string", "modules"));

	bool opEquals(string txt) { return toString == txt; }

	override string toString() {
		string result;
		string[] inner;
		
		if (name) result ~= "const "~name~" = ";
		result ~= "new Vuex.Store({";
		
		if (!_state.empty) inner ~= "state:{"~_state.toJS(true)~"}";
		if (!_getters.empty) inner ~= "getters:{"~_getters.toJS(true)~"}";
		if (!_mutations.empty) inner ~= "mutations:{"~_mutations.toJS(true)~"}";
		if (!_actions.empty) inner ~= "actions:{"~_actions.toJS(true)~"}";
		if (!_modules.empty) inner ~= "modules:{"~_modules.toJS(true)~"}";
		
		return result~inner.join(",")~"});";
	}
}
auto Vuex() { return new DVuex(); }
auto Vuex(string name) { return new DVuex(name); }

unittest {
	auto vuex = Vuex;
	assert(vuex.name("store") == "const store = new Vuex.Store({});");
	assert(vuex.state("today", "'2019-04-22'") == "const store = new Vuex.Store({state:{today:'2019-04-22'}});");
	assert(vuex.state("user", "'uim'") == "const store = new Vuex.Store({state:{today:'2019-04-22',user:'uim'}});");

	assert(Vuex("store").state("today", "'2019-04-22'").state("user", "'uim'") == "const store = new Vuex.Store({state:{today:'2019-04-22',user:'uim'}});");

	vuex = Vuex("store");
	assert(vuex.actions("go", "function(){}") == "const store = new Vuex.Store({actions:{go:function(){}}});");
}

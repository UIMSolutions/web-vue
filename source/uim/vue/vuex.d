module uim.vue.vuex;

import uim.vue;

class DVuex {
	this() {}
	this(string aName) { this(); _name = aName; }
	this(string aName, string[string] someStates, string[string] someGetters = null, string[string] someMutations = null, string[string] someActions = null, string[string] someModules = null) { 
		this(aName); 
		_state = someStates;
		_getters = someGetters;
		_mutations = someMutations;
		_actions = someActions;
		_modules = someModules;
		}

	private string _name;
	@property O name(this O)(string newName) { _name = newName; return cast(O)this; }
	@property string name() { return _name; }

	mixin(TPropertyAA!("string", "string", "state"));
	O state(this O)(string name, int value) { this.state(name, to!string(value)); return cast(O)this; } 
	O state(this O)(string name, Json value) { this.state(name, value.toString); return cast(O)this; } 
	O state(this O)(string name, string[] values) { this.state(name, "["~values.join(",")~"]"); return cast(O)this; } 
	O state(this O)(string name, Json[] values) {
		string[] results;
		foreach(value; values) { results ~= value.toString; }
		return this.state(name, results); 
	} 

	/* Vuex getters handler */
	mixin(TPropertyAA!("string", "string", "getters"));

	/* Vuex mutations handler */
	mixin(TPropertyAA!("string", "string", "mutations"));
	
	/* Vuex actions handler */
	mixin(TPropertyAA!("string", "string", "actions"));

	/* Vuex modules handler */
	mixin(TPropertyAA!("string", "string", "modules"));

	/* Compare strings */
	bool opEquals(string txt) { return toString == txt; }

	/* Convert Vuex object to string */
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
	writeln("Testing ", __MODULE__);
	
	auto vuex = Vuex;

	assert(Vuex("store") == "const store = new Vuex.Store({});");
	assert(Vuex.name("store") == "const store = new Vuex.Store({});");

	assert(Vuex("store").state("today", "'2019-04-22'") == "const store = new Vuex.Store({state:{today:'2019-04-22'}});");
	assert(Vuex("store").state("today", "'2019-04-22'").state("user", "'uim'") == "const store = new Vuex.Store({state:{today:'2019-04-22',user:'uim'}});");

	vuex = Vuex("store");
	assert(vuex.actions("go", "function(){}") == "const store = new Vuex.Store({actions:{go:function(){}}});");
}

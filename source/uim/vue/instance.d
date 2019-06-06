module uim.vue.instance;

import uim.vue;

class DVUEInstance : DVueObj {
	this() { super(); }
	this(string aName) { super(aName); }

	mixin(TProperty!("string", "variable"));
	mixin(TProperty!("string[]", "plugins"));
	mixin(TPropertyAA!("string", "string", "hooks"));
	mixin(TPropertyAA!("string", "string", "components"));
	mixin(TProperty!("string[]", "mixins"));

	bool opEquals(string value) {
		return toString() == value;
	}

	override string toString() {
		string result;
		string[] inner;

		if (variable) result ~= "var "~variable~" = ";
		result ~= "new Vue({";

		if (_name) inner ~= "el:'#"~_name~"'";
		if (_plugins) inner~=plugins.join(",");
		if (!_computed.empty) {
			string[] computedItems;
			foreach(key; _computed.keys.sort) computedItems ~= key~":function(){"~_computed[key]~"}"; 
			inner ~= "computed:{"~computedItems~"}";
		}
		if (!_data.empty) inner ~= "data:{"~_data.toJS(true)~"}";
		if (!_components.empty) inner ~= "components:{"~_components.toJS(true)~"}";
		if (!_methods.empty) inner ~= "methods:{"~_methods.toJS(true)~"}";
		if (!_watch.empty) inner ~= "watch:{"~_watch.toJS(true)~"}";
		if (!_filters.empty) inner ~= "filters:{"~_filters.toJS(true)~"}";
		if (_hooks) foreach(k, v; _hooks) inner~= k~":function(){"~v~"}";
		if (_mixins) inner~="mixins:["~mixins.join(",")~"]";

		return result~inner.join(",")~"});";
	}
}
auto VUEInstance() { return new DVUEInstance(); }
auto VUEInstance(string aName) { return new DVUEInstance(aName); }

unittest {
	writeln("Testing ", __MODULE__);

	auto app = VUEInstance;
	writeln(app);

	assert(VUEInstance == "new Vue({});");
	assert(VUEInstance("app") == "new Vue({el:'#app'});");
	assert(VUEInstance.name("app") == "new Vue({el:'#app'});");
	assert(VUEInstance.variable("vue").name("app") == "var vue = new Vue({el:'#app'});");
	writeln(app.variable("vue").name("app").data("a", "'b'"));
	writeln(app.variable("vue").name("app").data("a", "'b'").methodsAdd(["z":"zz", "x":"'xx'", "y":"'yy'"]));
	writeln(app.variable("vue").name("app").computed(["z":"zz", "x":"'xx'", "y":"'yy'"]));
}
module uim.vue.component;

import uim.vue;

class DVUEComponent : DVUEObj {
	this() { super(); }
	this(string aName) { super(aName); }

	mixin(TProperty!("string", "templ"));
	//O templ(this O)(DH5Obj h5) { _templ=h5.toString; return cast(O)this; }

	mixin(TProperty!("DVUEProp[string]", "props"));
	mixin(TProperty!("string", "render"));
	mixin(TPropertyAA!("string", "string", "extends"));

	bool opEquals(string value) {
		return globalRegistration() == value;
	}

	string globalRegistration() {
		debug writeln(_name);
		debug writeln(_templ);
		debug writeln(_props);
		debug writeln(_data);

		string result;
		string[] inner;

		result ~= "Vue.component(";
		if (_name) result ~= "'"~_name~"',";
		result ~= toString~");";
		return result;
	}

	override string toString() {
		string[] inner;
		if (!_extends.empty) inner ~= "extends:{"~_extends.toJS(true)~"}";
		if (!_computed.empty) inner ~= "computed:{"~_computed.toJS(true)~"}";
		if (!_data.empty) inner ~= "data:function(){return{"~_data.toJS(true)~"}}";
		
		if (_props) {
			bool simple = true;
			foreach(name, prop; _props) if (prop) simple = false;
			
			if (simple) {
				string[] names; foreach(key; props.keys.sort) names ~= "'"~key~"'";
				inner ~= "props:["~names.join(",")~"]"; 
			}
			else {
				string[] ps;
				foreach(key; props.keys.sort) {
					auto p = props[key];
					if (!p) ps ~= "'"~key~"'";
					else {
						if (p.types.length == 1) ps ~= key~":"~p.types[0];
						else ps ~= key~":["~p.types.join(",")~"]";
						if (p.defaultValue.length > 0) ps ~= "default:"~p.defaultValue;
						if (p.required) ps ~= "required:true";
						if (p.validator.length > 0) ps ~= "validator: function (value) {"~p.validator~"}";
					}
				}	
				inner ~= "props:{"~ps.join(",")~"}";
			}
		}
		
		if (_methods) {
			string[] mds;
			foreach(key; _methods.keys.sort) mds ~= key~": "~_methods[key]~"\n";
			inner ~= "\nmethods:{"~mds.join(",")~"}";
		}
		if (!_watch.empty) inner ~= "watch:{"~_watch.toJS(true)~"}";
		if (!_filters.empty) inner ~= "filters:{"~_filters.toJS(true)~"}";
		if (templ) inner ~= "template:'"~templ~"'"; 
		if (_render) inner ~= `render: function (createElement) {`~_render~`}`;
		return "{"~inner.join(",")~"}";
	}
}
auto VUEComponent() { return new DVUEComponent(); }
auto VUEComponent(string aName) { return new DVUEComponent(aName); }

unittest {
	writeln("Testing ", __MODULE__);

	assert(VUEComponent("xxx") == "Vue.component('xxx',{});"); 
	assert(VUEComponent.name("xxx") == "Vue.component('xxx',{});"); 
	assert(VUEComponent.name("xxx").templ("<h1>hello</h1>") == "Vue.component('xxx',{template:'<h1>hello</h1>'});"); 
	assert(VUEComponent.name("xxx").templ("<h1>hello</h1>").data(["x":"xx", "y":"yy"]) == "Vue.component('xxx',{data:function(){return{x:xx,y:yy}},template:'<h1>hello</h1>'});"); 
}
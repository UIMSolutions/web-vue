module uim.vue.component;

import uim.vue;

class DVUEComponent : DVueObj {
	this() { super(); }
	this(string aName) { super(aName); }

	mixin(TProperty!("string", "template_"));
	O template_(this O)(DH5Obj h5) { _template_=h5.toString; return cast(O)this; }

	mixin(TProperty!("string[string]", "props"));
	O props(this O)(string name, string values) { _props[name] = values; return cast(O)this; }

	mixin(TProperty!("string", "render"));
	mixin(TPropertyAA!("string", "string", "extends"));

	mixin(TProperty!("string", "script"));
	mixin(TProperty!("string", "style"));

	mixin(TProperty!("string[]", "components"));
	O components(this O)(string comp) { _components ~= comp; return cast(O)this; }

	mixin(TProperty!("string[string]", "computed"));
	O computed(this O)(string name, DJS txt) { _computed[name] = txt.toString; return cast(O)this; }	
	O computed(this O)(string name, string txt) { _computed[name] = txt; return cast(O)this; }	
	unittest {
		assert(VUEComponent.computed("a","b").computed == ["a":"b"]);
		writeln(VUEComponent.computed("a","b").toJS);
		assert(VUEComponent.computed("a","b") == "export default {computed:{a:function(){b}}}");
	}

	mixin(TProperty!("string[]", "mixins"));
	O mixins(this O)(string mix) { _mixins ~= mix; return cast(O)this; }

	mixin(TProperty!("string[]", "imports"));
	O imports(this O)(string text) { _imports ~= "import "~text; return cast(O)this; }

	mixin(TProperty!("string", "content"));

	bool opEquals(string value) {
		return globalRegistration() == value;
	}

	string globalRegistration() {
		debug writeln(_name);
		debug writeln(_template_);
		debug writeln(_props);
		debug writeln(_data);

		string result;
		string[] inner;

		result ~= "Vue.component(";
		if (_name) result ~= "'"~_name~"',";
		result ~= toString~");";
		return result;
	}

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toJS, "text/javascript");
	}

	string toVue() {
		string result;
		if (_template_) result ~= "<template>"~_template_~"</template>";
		if (_script) result ~= "<script>"~_script~"</script>";
		if (_style) result ~= "<style scoped>"~_style~"</style>";
		return result;
	}

	override string toString() {
		if (!_content) {
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
					/* foreach(key; props.keys.sort) {
						auto p = props[key];
						if (!p) ps ~= "'"~key~"'";
						else {
							if (p.types.length == 1) ps ~= key~":"~p.types[0];
							else ps ~= key~":["~p.types.join(",")~"]";
							if (p.defaultValue.length > 0) ps ~= "default:"~p.defaultValue;
							if (p.required) ps ~= "required:true";
							if (p.validator.length > 0) ps ~= "validator: function (value) {"~p.validator~"}";
						}
					}	*/
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
			if (_template_) inner ~= "template:'"~_template_~"'"; 
			if (_render) inner ~= `render: function (createElement) {`~_render~`}`;
			content =  "{"~inner.join(",")~"}";
		}
		return _content;
	}

	string toJS() {
		string result;
		if (imports) result ~= imports.join("");

		string[] inner;
		if (_name) inner ~= `name:"%s"`.format(_name);	
  		if (_components) inner ~= `components:{%s}`.format(_components.join(","));
  		if (_mixins) inner ~= `mixins:[%s]`.format(_mixins.join(","));
		
		string[] p;
		foreach(k, v; _props) p ~= "%s:%s".format(k, v);
		if (p) inner ~= "props:{%s}".format(p.join(","));

		string[] m;
		foreach(k, v; _methods) m ~= "%s{%s}".format(k, v);
		if (m) inner ~= "methods:{%s}".format(m.join(","));

		string[] c;
		writeln(_computed);
		foreach(k, v; _computed) c ~= "%s{%s}".format(k, v);
		if (c) inner ~= "computed:{%s}".format(c.join(","));

		if (_template_) inner ~= "template:`%s`".format(_template_);	
		return result~"export default {"~inner.join(",")~"}";
	}
}
auto VUEComponent() { return new DVUEComponent(); }
auto VUEComponent(string aName) { return new DVUEComponent(aName); }

unittest {
	writeln("Testing ", __MODULE__);

	assert(VUEComponent("xxx") == "Vue.component('xxx',{});"); 
	assert(VUEComponent.name("xxx") == "Vue.component('xxx',{});"); 
	assert(VUEComponent.name("xxx").template_("<h1>hello</h1>") == "Vue.component('xxx',{template:'<h1>hello</h1>'});"); 
	assert(VUEComponent.name("xxx").template_("<h1>hello</h1>").data(["x":"xx", "y":"yy"]) == "Vue.component('xxx',{data:function(){return{x:xx,y:yy}},template:'<h1>hello</h1>'});"); 
}
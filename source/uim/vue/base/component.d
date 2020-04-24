module uim.vue.base.component;

import uim.vue;

class DVUEComponent : DVUEObj {
	this() { super(); }
	this(DVUEApp anApp) { this().app(anApp); }
	this(string aName) { this().name(aName); }
	this(DVUEApp anApp, string aName) { this(anApp).name(aName); }

	mixin(TProperty!("DVUEApp", "app"));

	string[] _classes;
	auto classes() { return _classes; }
	O classes(this O)(string[] entries...) { _classes ~= entries; return cast(O)this; }
	O classes(this O)(string[] entries) { _classes ~= entries; return cast(O)this; }
	unittest {
	}

	/**
	* filters - allows to define filters that can be used to apply common text formatting
	* Example (pretty version, default is minimized)
	* VUEComponent.filters("capitalize", "if (!value) return '';value = value.toString();return value.charAt(0).toUpperCase() + value.slice(1);")
	* filters: {
  *		capitalize: function (value) {
  *  		if (!value) return '';
  *  		value = value.toString();
  *  		return value.charAt(0).toUpperCase() + value.slice(1);
  *		}
	*	}
	*/
	mixin(XStringAA!"filters"); 
	unittest {
	}

	/// Mixins are reusable functionalities for Vue components
	mixin(XStringArray!"mixins"); 
	unittest {
		assert(VUEComponent.mixins("a").mixins == ["a"]);
		assert(VUEComponent.mixins(["a","b"]).mixins == ["a","b"]);
		assert(VUEComponent.mixins("a").mixins("x").mixins == ["a", "x"]);
		// TODO assert(VUEComponent.mixins("a").mixins("x").removeMixins("a").mixins == ["x"]);
		assert(VUEComponent.mixins(["a","b"]).clearMixins.mixins == null);
	}

	mixin(XStringAA!"props");
	O props(this O)(string name, string datatype, string defaultValue, bool required = false) {
		string[] results;
		results ~= (datatype ? "type:%s".format(datatype) : "type:String");
		if (defaultValue) results ~= (defaultValue.indexOf("return") >= 0 ? "default:function(){%s}".format(defaultValue) : "default:%s".format(defaultValue)); 
		if (required) results ~= "required:true";
		_props[name] = "{"~results.join(",")~"}";
		return cast(O)this; }
	O props(this O)(string name, string datatype, string defaultValue, string validate, bool required = false) {
		string[] results;
		results ~= (datatype ? "type:%s".format(datatype) : "type:String");
		if (defaultValue) results ~= (defaultValue.indexOf("return") >= 0 ? "default:function(){%s}".format(defaultValue) : "default:%s".format(defaultValue)); 
		if (validate) results ~=  "validator:function(value){"~validate~"}";
		if (required) results ~= "required:true";
		_props[name] = "{"~results.join(",")~"}";
		return cast(O)this; }
	unittest {
		assert(VUEComponent.props("a", "x").props == ["a":"x"]);
		assert(VUEComponent.props(["a":"b"]).props == ["a":"b"]);
	}

	mixin(XString!"render");
	unittest {
		assert(VUEComponent.render("a").render == "a");
		assert(VUEComponent.render("a").render("x").render == "ax");
		assert(VUEComponent.render("a").clearRender.render == null);
	}

	/**
	* extends - Allows declaratively extending another component without having to use Vue.extend. 
	* This is primarily intended to make it easier to extend between single file components.
	*/
	mixin(XStringArray!"extends");
	unittest {
		assert(VUEComponent.extends("a").extends == ["a"]);
		assert(VUEComponent.extends(["a","b"]).extends == ["a","b"]);
		assert(VUEComponent.extends("a").extends("x").extends == ["a", "x"]);
		// TODO: assert(VUEComponent.extends("a").extends("x").removeExtends("a").extends == ["x"]);
		assert(VUEComponent.extends(["a","b"]).clearExtends.extends == null);
	}

	mixin(XString!"script"); 
	unittest {
		assert(VUEComponent.script("a").script == "a");
		assert(VUEComponent.script("a").script("x").script == "ax");
		assert(VUEComponent.script("a").clearScript.script == null);
	}

	mixin(XString!"style"); 
	unittest {
		assert(VUEComponent.style("a").style == "a");
		assert(VUEComponent.style("a").style("x").style == "ax");
		assert(VUEComponent.style("a").clearStyle.style == null);
	}

	// imports
	O imports(this O)(DVUEComponent[] someComponents...) { this.components(someComponents); return cast(O)this; }
	O imports(this O)(DVUEComponent[] someComponents) { this.components(someComponents); return cast(O)this; }
	
	O imports(this O)(DVUEModule aModule) { this.imports(aModule.name, "../module/"~aModule.name~".js"); return cast(O)this; }
	O imports(this O)(DVUEMixin aMixin) { this.imports(aMixin.name, "../mixin/"~aMixin.name~".js"); return cast(O)this; }
	O imports(this O)(string name, string path) { this.imports(name~" from '"~path~"'"); return cast(O)this; }
	O imports(this O)(string text) { _imports ~= "import "~text~";"; return cast(O)this; }

	/**
	 * components - Local registration of components
	 * For each property in the components object, 
	 * the key will be the name of the custom element, while the value will contain the options object for the component.
	 * Key and name could be the same. Example:
	 * components: {
   * 	ComponentA: ComponentA,
   * 	'component-b': ComponentB
   * }
	 	*/
	protected string[string] _components;
	auto components() { return _components; }
	O clearComponents(this O)() { _components = null; return cast(O)this; }
	O components(this O)(string[] someComponents...) { foreach(name; someComponents) this.components(name, name); return cast(O)this; }
	O components(this O)(string[string] someComponents) { foreach(key, name; someComponents) component(key, name); return cast(O)this; }
	O components(this O)(string name, string aComponent) { _components[name] = aComponent; return cast(O)this;  }
	unittest {
		assert(VUEComponent("test").components("componentA") == `Vue.component('test',{components:{componentA:componentA}});`); 
		assert(VUEComponent("test").components("component-a", "componentA") == `Vue.component('test',{components:{'component-a':componentA}});`);
	}
/* ERROR
	// Local registration using imports
	O components(this O)(DVUEComponent[] someComponents...) { foreach(c; someComponents) this.component(c); return cast(O)this; }
	O components(this O)(DVUEComponent[] someComponents) { foreach(c; someComponents) component(c); return cast(O)this; }
	O component(this O)(DVUEComponent aComponent) { 
		this.imports(aComponent.name, "./"~aComponent.name~".js").component(aComponent.name); 
		if (app) app.components(aComponent); 
		return cast(O)this; }
	unittest {
		assert(VUEComponent.component("componentA").components == ["componentA":"componentA"]);
		assert(VUEComponent.component("'component-a'", "componentA").components == ["'component-a'":"componentA"]);
	}
*/
	mixin(TProperty!("string", "content"));

	string globalRegistration() {/*
		// debug writeln("Name = ",_name);
		// debug writeln("Template = ",_template_);
		// debug writeln("Props = ", _props);
		// debug writeln("Data = ", _data);
*/
		string result;
		if (_name) result ~= "'"~_name~"'";

		auto mySettings = settings;
		if (_template_) mySettings["template"] = "`%s`".format(_template_);	

		if (mySettings) result ~= (result ? ",":"")~mySettings.toJS(true);
		return "Vue.component("~result~");";
	}
	unittest {
		assert(VUEComponent("test") == `Vue.component('test');`);
		assert(VUEComponent("test").template_("xyz") == "Vue.component('test',{template:`xyz`});",
		"Wrong? -> "~VUEComponent("test").template_("xyz").toString);
	}

	void request(HTTPServerRequest req, HTTPServerResponse res) {
		res.writeBody(toString, "text/javascript");
	}

	string toVue() {
		string result;
		if (_template_) result ~= "<template>"~_template_~"</template>";
		if (_script) result ~= "<script>"~_script~"</script>";
		if (_style) result ~= "<style scoped>"~_style~"</style>";
		return result;
	}
	unittest{
		/// TODO
	}

	override string[string] settings() {
		string[string] results = super.settings;
		if (_classes) this.computed("classes", `return`~this.classes.toJS~`;`);

		if (_components) {
			string[string] componentsForVue;
			foreach(kv; _components.byKeyValue) {
				if (kv.key.indexOf("-") >= 0) componentsForVue["'"~kv.key~"'"] = kv.value; 
				else componentsForVue[kv.key] = kv.value;
			}
			results["components"] = componentsForVue.toJS;
		}
		if (_data) results["data"] = "function(){return"~_data.toJS(true)~"}";
		if (_filters) {
			string[string] filtersForVue;
			foreach(kv; _filters.byKeyValue) filtersForVue[kv.key] = "function(value){"~kv.value~"}";
			results["filters"] = filtersForVue.toJS;
		}
		if (_mixins) results["mixins"] = _mixins.toJS;
		if (_props) {
			string[string] propsForVue;
			foreach(kv; props.byKeyValue) { propsForVue[kv.key] = "{"~kv.value~"}"; }
			results["props"] = propsForVue.toJS;
		}
		if (_watch) results["watch"] = _watch.toJS;

		return results;
	}
	unittest{
		/// TODO
	}

	override bool opEquals(string txt) { return toString == txt; }
	override string toString() { return globalRegistration; }
	unittest{
		/// TODO
	}
}
auto VUEComponent() { return new DVUEComponent(); }
auto VUEComponent(string aName) { return new DVUEComponent(aName); }
auto VUEComponent(DVUEApp anApp) { return new DVUEComponent(anApp); }
auto VUEComponent(DVUEApp anApp, string aName) { return new DVUEComponent(anApp, aName); }
unittest {
	assert(VUEComponent("xxx") == "Vue.component('xxx');"); 
	assert(VUEComponent.name("xxx") == "Vue.component('xxx');"); 
	assert(VUEComponent.name("xxx").template_("<h1>hello</h1>") == "Vue.component('xxx',{template:`<h1>hello</h1>`});"); 
	assert(VUEComponent.name("xxx").template_("<h1>hello</h1>").data(["x":"xx", "y":"yy"]) == "Vue.component('xxx',{data:function(){return{x:xx,y:yy}},template:`<h1>hello</h1>`});"); 
// test computed
	assert(VUEComponent.computed("a","return b;") == "Vue.component({computed:{a:function(){return b;}}});", 
	"Wrong? -> "~VUEComponent.computed("a","return b;").toString);
	assert(VUEComponent.computed("a","return b;").computed("x","return z;") == "Vue.component({computed:{a:function(){return b;},x:function(){return z;}}});", 
	"Wrong? -> "~VUEComponent.computed("a","return b;").computed("x","return z;").toString);
	assert(VUEComponent.computed(["a":"return b;", "x":"return z;"]) == "Vue.component({computed:{a:function(){return b;},x:function(){return z;}}});", 
	"Wrong? -> "~VUEComponent.computed(["a":"return b;", "x":"return z;"]).toString);
	// test methods
	assert(VUEComponent.methods("a()","return b;") == "Vue.component({methods:{a(){return b;}}});", 
	"Wrong? -> "~VUEComponent.methods("a()","return b;").toString);
	assert(VUEComponent.methods("a()","return b;").methods("x()","return z;") == "Vue.component({methods:{a(){return b;},x(){return z;}}});", 
	"Wrong? -> "~VUEComponent.methods("a()","return b;").methods("x()","return z;").toString);
	assert(VUEComponent.methods(["a()":"return b;", "x()":"return z;"]) == "Vue.component({methods:{a(){return b;},x(){return z;}}});", 
	"Wrong? -> "~VUEComponent.methods(["a()":"return b;", "x()":"return z;"]).toString);
}	
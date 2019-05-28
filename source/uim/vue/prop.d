module uim.vue.prop;

import uim.vue;

class DVUEProp {
	this(string aName) { _name = aName; }
	this(string aName, string[] someTypes) { this(aName); this.types = someTypes; }
	this(string aName, string[] someTypes, string aDefaultValue) { this(aName, someTypes); this.defaultValue = aDefaultValue; }
	this(string aName, string[] someTypes, string aDefaultValue, bool isRequired) { this(aName, someTypes, aDefaultValue); this.required = isRequired; }
	this(string aName, string[] someTypes, string aDefaultValue, bool isRequired, string aValidator) { this(aName, someTypes, aDefaultValue, isRequired); this.validator = aValidator; }

	mixin(TProperty!("string", "name"));
	mixin(TProperty!("string[]", "types")); // String, Number, Boolean, Array, Object, Date, Function, Symbol
	mixin(TProperty!("string", "defaultValue"));
	mixin(TProperty!("bool", "required"));
	mixin(TProperty!("string", "validator"));
}
auto VUEProp(string aName) { return new DVUEProp(aName); }
auto VUEProp(string aName, string[] types) { return new DVUEProp(aName, types); }
auto VUEProp(string aName, string[] types, string defaultValue) { return new DVUEProp(aName, types, defaultValue); }
auto VUEProp(string aName, string[] types, string defaultValue, bool required) { return new DVUEProp(aName, types, defaultValue, required); }
auto VUEProp(string aName, string[] types, string defaultValue, bool required, string validator) { return new DVUEProp(aName, types, defaultValue, required, validator); }

unittest {
	writeln("Testing ", __MODULE__);

	auto prop = VUEProp("SomeName");
	assert(VUEProp("SomeName").name == "SomeName");
	assert(VUEProp.name("SomeName").name == "SomeName");
	assert(prop.name("newName").name == "newName");
	assert(prop.types(["aType"]).types == ["aType"]);
	assert(prop.defaultValue("aDefault").defaultValue == "aDefault");
	assert(prop.required(true).required);
	assert(prop.validator("aValidator").validator == "aValidator");
}


module uim.vue.classes.prop;

import uim.vue;

@safe:

class DVUEProp {
	this() { }
	this(string aName) { this(); _name = aName; }
	this(string aName, string[] someTypes) { this(aName); this.types = someTypes; }
	this(string aName, string[] someTypes, string aDefaultValue) { this(aName, someTypes); this.defaultValue = aDefaultValue; }
	this(string aName, string[] someTypes, string aDefaultValue, bool isRequired) { this(aName, someTypes, aDefaultValue); this.required = isRequired; }
	this(string aName, string[] someTypes, string aDefaultValue, bool isRequired, string aValidator) { this(aName, someTypes, aDefaultValue, isRequired); this.validator = aValidator; }

	mixin(TProperty!("string", "name"));
	mixin(TProperty!("string[]", "types")); // String, Number, Boolean, Array, Object, Date, Function, Symbol
	mixin(TProperty!("string", "defaultValue"));
	mixin(TProperty!("bool", "required"));
	mixin(TProperty!("string", "validator"));

	override string toString() {
		string[string] results;

		if (types) {
			if (types.length == 1) results["type"] = types[0];
			else results["type"] = "[%s]".format(types.join(","));
		}
		if (required) results["required"] = "true";
		if (defaultValue.length>0) results["default"] = defaultValue;
		if (validator.length>0) results["validator"] = validator;

		return name~":"~results.toJS;
	}
}
auto VUEProp() { return new DVUEProp(); }
auto VUEProp(string aName) { return new DVUEProp(aName); }
auto VUEProp(string aName, string[] types) { return new DVUEProp(aName, types); }
auto VUEProp(string aName, string[] types, string defaultValue) { return new DVUEProp(aName, types, defaultValue); }
auto VUEProp(string aName, string[] types, string defaultValue, bool required) { return new DVUEProp(aName, types, defaultValue, required); }
auto VUEProp(string aName, string[] types, string defaultValue, bool required, string validator) { return new DVUEProp(aName, types, defaultValue, required, validator); }
///
unittest {
	auto prop = VUEProp("SomeName");
	assert(VUEProp("SomeName").name == "SomeName");
	assert(VUEProp.name("SomeName").name == "SomeName");
	assert(prop.name("newName").name == "newName");
	assert(prop.types(["aType"]).types == ["aType"]);
	assert(prop.defaultValue("aDefault").defaultValue == "aDefault");
	assert(prop.required(true).required);
	assert(prop.validator("aValidator").validator == "aValidator");
}


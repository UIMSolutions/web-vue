module uim.vue;

// Standard Libraries
public import std.stdio;
public import std.string;

// External Libraries
public import vibe.vibe;

// Libraries
public import uim.core;
public import uim.oop;
public import uim.html;
public import uim.javascript;
// public import uim.json;

// Packages
public import uim.vue.apps;
public import uim.vue.content;
public import uim.vue.data;
public import uim.vue.base;
public import uim.vue.html;
public import uim.vue.global;

// Modules
public import uim.vue.main;
public import uim.vue.prop;
public import uim.vue.props;
public import uim.vue.routers;
public import uim.vue.state;

alias string function(string, string[string]) LAYOUTFUNC;
/******************** 
 * vOn - directive to listen to DOM events and run some JavaScript when they’re triggered.
 * Params:
 * 		h5 			= HTML5 Obj
 * 		eventName 	= name of event like "click" or "mousemove"
 * 		modifiers 	= "stop","prevent","capture","self","once","passive"
 * 					for mouse action "left", "right", "middle"
 * Examples:
 * --------------------
 * H5DIV.vOn("mousemove", "function") results in `<div v-on:mousemove="function"></div>
 * -------------------- 
 ******************** */ 
T vOn(T:DH5Obj)(T h5, string eventName, string value, string[] modifiers = null) {
	if (modifiers) return h5.attribute("@"~eventName~"."~modifiers.join("."), value);
	return h5.attribute("@"~eventName, value);
}
unittest {
	assert(H5Div.vOn("mousemove", "funcName()") == `<div @mousemove="funcName()"></div>`);
}

/******************** 
 * vKey - directive to listen to keyboard events and run some JavaScript when they’re triggered.
 * Params:
 * 		h5 			= HTML5 Obj
 * 		modifiers 	= "enter", "tab", "delete", "esc", "space", "up", "down", "left", "right" or keycode
 * 					also possible to use system keys "ctrl", "alt", "shift", "meta" or in combination with keycode
 * Examples:
 * --------------------
 * H5DIV.vKey("submit") results in `<div @keyup="submit"></div>
 * -------------------- 
 ******************** */ 
T vKey(T:DH5Obj)(T h5, string value, string[] modifiers = null) {
	if (modifiers) return h5.attribute("@keyup."~modifiers.join("."), value);
	return h5.attribute("@keyup", value);
}

/********************
 * vBind:
******************** */
T vBind(T:DH5Obj)(T h5, string name, string value) {
	return h5.attribute(":"~name, value);
}

/********************
 * vHtml:
******************** */
T vHtml(T:DH5Obj)(T h5, DH5Obj value) { return h5.attribute("v-html", value.toHTML); }
T vHtml(T:DH5Obj)(T h5, string value) { return h5.attribute("v-html", value); }

/********************
 * vIf:
******************** */
T vIf(T:DH5Obj)(T h5, string name, string value) {
	return h5.attribute("v-id:"~name, value);
}

/********************
 * vFor - directive to render a list of items based on an array
 * Examples:
 * --------------------
 * H5LI("{{ item.message }}").vFor("item in items") results in <li v-for="item in items">{{ item.message }}</li>
 * H5LI.vFor("item in items")("{{ item.message }}") same result like above
 * --------------------
******************** */
T vFor(T:DH5Obj)(T h5, string value, string key = null) {
	if (key) return h5.attribute("v-for", value).attribute(":key", key);
	return h5.attribute("v-for", value);
}
unittest {
	assert(H5Div.vFor("item in items") == `<div v-for="item in items"></div>`);
	assert(H5Div.vFor("item in items", "item.id") == `<div :key="item.id" v-for="item in items"></div>`);
}

/********************
 * vModel:
******************** */
T vModel(T:DH5Obj)(T h5, string value) {
	return h5.attribute("v-model", value);
}

/********************
 * vShow:
******************** */
T vShow(T:DH5Obj)(T h5, string value) {
	return h5.attribute("v-show", value);
}

/********************
 * vElse:
******************** */
T vElse(T:DH5Obj)(T h5) { return h5.attribute("v-else", "v-else"); }

/********************
 * vClass:
******************** */
T vClass(T:DH5Obj)(T h5, string[] values) { return h5.attribute(":class", "["~values.join(",")~"]"); }
T vClass(T:DH5Obj)(T h5, string[string] values, bool sort = true) {
	string[] inner;
	if (sort) foreach(k; values.keys.sort) {
		if (k.indexOf("-") == -1) inner~="%s:%s".format(k, values[k]);
		else inner~="'%s':%s".format(k, values[k]);
	}
	else foreach(k, v; values) {
		if (k.indexOf("-") == -1) inner~="%s:%s".format(k, v);
		else inner~="'%s':%s".format(k, v);
	}
	return h5.vClass("{"~inner.join(",")~"}");
}
T vClass(T:DH5Obj)(T h5, string value) { return h5.attribute(":class", value); }

unittest {
	assert(H5Div.vKey("function", ["13"]) == `<div @keyup.13="function"></div>`);

	assert(H5Li("{{ item.message }}").vFor("item in items") == `<li v-for="item in items">{{ item.message }}</li>`);
	assert(H5Li.vFor("item in items")("{{ item.message }}") == `<li v-for="item in items">{{ item.message }}</li>`);

	assert(H5Div.vClass("xy") == `<div :class="xy"></div>`);
	assert(H5Div.vClass(["x":"y"]) == `<div :class="{x:y}"></div>`);
}

/********************
 * toTemplate:
******************** */
string toTemplate(DH5Obj[] someH5Objs) {
	string result;
	foreach(h5; someH5Objs) {
		result ~= h5.toTemplate;
	}
	return result;
}

string toTemplate(DH5Obj aH5Obj) {	
	if (aH5Obj.tag.length == 0) return "%s".format(aH5Obj);
	if (aH5Obj.single) {
		if (aH5Obj.attributes.length > 0)
			return "<%s%s>".format(aH5Obj.tag, aH5Obj.attsToHTML);
		return "<%s>".format(aH5Obj.tag);
	}
	else {
		if (aH5Obj.attributes.length > 0)
			return "<%s%s>%s</%s>".format(aH5Obj.tag, aH5Obj.attsToHTML, aH5Obj.html.toTemplate, aH5Obj.tag);
		return "<%s>%s</%s>".format(aH5Obj.tag, aH5Obj.html.toTemplate, aH5Obj.tag);
	}
}
unittest {
}


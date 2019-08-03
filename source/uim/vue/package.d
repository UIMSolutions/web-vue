module uim.vue;

public import vibe.vibe;

// libraries
public import uim.core;
public import uim.oop;
public import uim.web;
public import uim.html;
public import uim.javascript;
// public import uim.json;

// modules
public import uim.vue.app;
public import uim.vue.component;
public import uim.vue.content;
public import uim.vue.data;
public import uim.vue.index;
public import uim.vue.instance;
public import uim.vue.main;
public import uim.vue.mixins;
public import uim.vue.module_;
public import uim.vue.obj;
public import uim.vue.page;
public import uim.vue.prop;
public import uim.vue.props;
public import uim.vue.router;
public import uim.vue.vuex;

/** vOn - directive to listen to DOM events and run some JavaScript when they’re triggered.
 * Params:
 * 		h5 			= HTML5 Obj
 * 		eventName 	= name of event like "click" or "mousemove"
 * 		modifiers 	= "stop","prevent","capture","self","once","passive"
 * 					for mouse action "left", "right", "middle"
 * Examples:
 * --------------------
 * H5DIV.vOn("mousemove", "function") results in `<div v-on:mousemove="function"></div>
 * -------------------- */ 
T vOn(T:DH5Obj)(T h5, string eventName, string value, string[] modifiers = null) {
	if (modifiers) return h5.attribute("@"~eventName~"."~modifiers.join("."), value);
	return h5.attribute("@"~eventName, value);
}
/** vKey - directive to listen to keyboard events and run some JavaScript when they’re triggered.
 * Params:
 * 		h5 			= HTML5 Obj
 * 		modifiers 	= "enter", "tab", "delete", "esc", "space", "up", "down", "left", "right" or keycode
 * 					also possible to use system keys "ctrl", "alt", "shift", "meta" or in combination with keycode
 * Examples:
 * --------------------
 * H5DIV.vKey("submit") results in `<div @keyup="submit"></div>
 * -------------------- */ 
T vKey(T:DH5Obj)(T h5, string value, string[] modifiers = null) {
	if (modifiers) return h5.attribute("@keyup."~modifiers.join("."), value);
	return h5.attribute("@keyup", value);
}
T vBind(T:DH5Obj)(T h5, string name, string value) {
	return h5.attribute(":"~name, value);
}
T vHtml(T:DH5Obj)(T h5, string value) {
	return h5.attribute("v-html", value);
}

T vIf(T:DH5Obj)(T h5, string name, string value) {
	return h5.attribute("v-id:"~name, value);
}
/** vFor - directive to render a list of items based on an array
 * Examples:
 * --------------------
 * H5LI("{{ item.message }}").vFor("item in items") results in <li v-for="item in items">{{ item.message }}</li>
 * H5LI.vFor("item in items")("{{ item.message }}") same result like above
 * --------------------
 */
T vFor(T:DH5Obj)(T h5, string value) {
	return h5.attribute("v-for", value);
}
T vModel(T:DH5Obj)(T h5, string value) {
	return h5.attribute("v-model", value);
}
T vShow(T:DH5Obj)(T h5, string value) {
	return h5.attribute("v-show", value);
}
T vElse(T:DH5Obj)(T h5) {
	return h5.attribute("v-show", "v-show");
}
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
T vClass(T:DH5Obj)(T h5, string value) {
	return h5.attribute(":class", value);
}
unittest {
	writeln("Testing ", __MODULE__);

	assert(H5DIV.vOn("mousemove", "function") == `<div @mousemove="function"></div>`);
	assert(H5DIV.vKey("function", ["13"]) == `<div @keyup.13="function"></div>`);

	assert(H5LI("{{ item.message }}").vFor("item in items") == `<li v-for="item in items">{{ item.message }}</li>`);
	assert(H5LI.vFor("item in items")("{{ item.message }}") == `<li v-for="item in items">{{ item.message }}</li>`);

	assert(H5DIV.vClass("xy") == `<div :class="xy"></div>`);
	assert(H5DIV.vClass(["x":"y"]) == `<div :class="{x:y}"></div>`);
}

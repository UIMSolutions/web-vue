module uim.vue.html.transitiongroup;

import uim.html;

class DH5TransitionGroup : DH5Obj {
	mixin(H5This!"transition-group");
}
mixin(H5Short!"TransitionGroup");

unittest {
	assert(Assert(H5TransitionGroup,"<transition-group></transition-group>"));
}
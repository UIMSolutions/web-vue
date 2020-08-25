module uim.vue.html.transition;

import uim.html;

class DH5Transition : DH5Obj {
	mixin(H5This!"transition");
}
mixin(H5Short!"Transition");

unittest {
	assert(Assert(H5Transition,"<transition></transition>"));
}
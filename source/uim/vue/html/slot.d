module uim.vue.html.slot;

import uim.html;

@safe:

class DH5Slot : DH5Obj {
	mixin(H5This!"slot");
}
mixin(H5Short!"Slot");

unittest {
	assert(Assert(H5Slot,"<slot></slot>"));
}
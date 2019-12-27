module uim.vue.props;

import uim.vue;

class DVUEProps {
	this() {}

	mixin(TProperty!("DVUEProp[]", "items"));
}
auto VUEProps() { return new DVUEProps(); }

unittest {
	
}

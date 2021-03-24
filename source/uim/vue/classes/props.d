module uim.vue.classes.props;

import uim.vue;

@safe:

class DVUEProps {
	this() {}

	mixin(TProperty!("DVUEProp[]", "items"));
}
auto VUEProps() { return new DVUEProps(); }

unittest {
	
}

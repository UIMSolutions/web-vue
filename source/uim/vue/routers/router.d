module uim.vue.routers.router;

class DVueRouter {
	this() {}

	alias opEquals = Object.opEquals;
	bool opEquals(string html) { return toString == html; }
	bool opEquals(DVueRouter value) { return toString == value.toString; }
	
	override string toString() {
		return "";
	}
}
auto VueRouter() { return new DVueRouter; }
///
unittest {
	assert(VueRouter == "");
}
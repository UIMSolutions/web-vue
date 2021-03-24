module uim.vue.apps.page;

import uim.vue;

@safe:

class DVUEPage : DH5AppPage {
	this() { super(); }
	this(DVUEApp anApp) { this().app(anApp); }
	this(string aName) { this().name(aName); }
	this(DVUEApp anApp, string aName) { this(anApp).name(aName); }

	// Vue instances in a page
	mixin(XPropertyAA!("string", "DVUEInstance", "instances"));
	unittest {
		assert(VUEPage.instances(["test": VUEInstance("test"), "test2": VUEInstance("test2")]).instances().length == 2);
/* 		assert(VUEPage.instances([VUEInstance.name("test"), VUEInstance.name("test2")]).instances("test")[0].name == "test");
		assert(VUEPage.instances(VUEInstance.name("test")).instances(VUEInstance.name("test2")).instances("test")[0].name == "test");
 */	}

	mixin(XPropertyAA!("string", "DVuex", "stores"));
	unittest {
		assert(VUEPage.stores(["test": Vuex("test"), "test2": Vuex("test2")]).stores().length == 2);
	}

	mixin(XPropertyAA!("string", "DVUEComponent", "components"));
	unittest {
		/// TODO
	}

	override void request(StringAA reqParameters, HTTPServerResponse res) {
    	reqParameters["vueApp"] = VUEInstance("app").toString;
    	// parameters["jsStart"] = UIMIconbarHorizontal.toVUEComponent.globalRegistration;

		super.request(reqParameters, res);
  }
}
auto VUEPage() { return new DVUEPage; }
auto VUEPage(string aName) { return new DVUEPage(aName); }
auto VUEPage(DVUEApp anApp) { return new DVUEPage(anApp); }
auto VUEPage(DVUEApp anApp, string aName) { return new DVUEPage(anApp, aName); }

unittest {
}


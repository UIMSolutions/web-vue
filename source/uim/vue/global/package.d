module uim.vue.global;

import uim.vue;

@safe:

/**
* vueDirective - Global register of custom directives
* name: Name of directive, use as v-<name> (test should be used as v-test )
* bind, inserted and update are hook functions 
* vDirective - Global register of custom directives
**/
auto vueDirective(string name, string bind, string inserted, string update) {
    string[] content;

    /// bind: hook which called only once, when the directive is first bound to the element (For one-time setup work)
    if (bind) content~=`bind:%s`.format(bind);

    /// inserted: hook which called when the bound element has been inserted into its parent node
    if (inserted) content~=`inserted:%s`.format(inserted);

   /// update: hook which called after the containing component’s VNode has updated, but possibly before its children have updated.
    if (update) content~=`update:%s`.format(update);

    return `Vue.directive('%s',{%s});`.format(name, content.join(","));
}
unittest {}

/// Use of a directive in a HTML element
T vDirective(T:DH5Obj)(T h5, string name, string value) { return h5.attribute("v-"~name, value); }
unittest {
    assert(H5Div.vDirective("test", "123") == `<div v-test="123"></div>`);
}
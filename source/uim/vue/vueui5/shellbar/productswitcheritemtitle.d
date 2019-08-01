module uim.vue.vueui5.shellbar.productswitcheritemtitle;

public import uim.vue;

static this() {
    import uim.vue.vueui5;
    vueShellBarProductSwitcherItemTitle = VUEComponent.
        templ(`
<span class="fd-product-switcher__product-title">
    <slot />
  </span>`)
        .script(`
export default {
  name: "FdShellBarProductSwitcherItemTitle"
};`); 
}
unittest {
    
}
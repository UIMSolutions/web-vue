module uim.vue.vueui5.shellbar.productswitcheritemimg;

public import uim.vue;

static this() {
    import uim.vue.vueui5;
    vueShellBarProductSwitcherItemImg = VUEComponent.
        templ(`
<span class="fd-product-switcher__product-icon" v-on="$listeners">
  <slot>
    <img :src="src" v-bind="$attrs" />
  </slot>
</span>`)
        .script(`
export default {
  name: "FdShellBarProductSwitcherItemImg",
  inheritAttrs: false,
  props: {
    src: String
  }
};`); 
}
unittest {
    
}
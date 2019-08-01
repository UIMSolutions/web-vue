module uim.vue.vueui5.legend;

public import uim.vue;

static this() {
    import uim.vue.vueui5;
    vueLegend = VUEComponent
      .script(`
export default {
  name: "FdLegend"
};`)
      .templ(`
<legend class="fd-form__legend">
    <slot />
  </legend>`);
}
unittest {
    
}
module uim.vue.vueui5.spinner;

public import uim.vue;

static this() {
    import uim.vue.vueui5;
    vueSpinner = VUEComponent.
        templ(`
<div class="fd-spinner" aria-hidden="false" :aria-label="ariaLabel">
  <div />
</div>`)
        .script(`
export default {
  name: "FdSpinner",
  props: {
    ariaLabel: { type: String, default: "Loading" }
  }
};`); 
}
unittest {
    
}
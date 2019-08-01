module uim.vue.vueui5.fieldset;

public import uim.vue;

static this() {
    uim.vue.vueui5.
    vueFieldSet = VUEComponent.
        templ(`
  <fieldset class="fd-form__set">
    <slot />
  </fieldset>`)
        .script(`
export default {
  name: "FdFieldSet"
};`); 
}
unittest {
    
}
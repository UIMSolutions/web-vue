module uim.vue.vueui5.form.group;

public import uim.vue;

static this() {
    uim.vue.vueui5.
    vueFormGroup = VUEComponent.
        templ(`
<div class="fd-form__group">
    <slot />
  </div>        `)
        .script(`
export default {
  name: "FdFormGroup",
  provide() {
    return {
      formGroup: this
    };
  },
  props: {
    inline: { type: Boolean, default: false }
  }
};`); 
}
unittest {
    
}
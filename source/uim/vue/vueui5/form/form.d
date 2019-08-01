module uim.vue.vueui5.form.form;

public import uim.vue;

static this() {
    uim.vue.vueui5.
    vueForm = VUEComponent.
        templ(`
<form>
    <slot />
  </form>        `)
        .script(`
export default {
  name: "FdForm"
};        `); 
}
unittest {
    
}
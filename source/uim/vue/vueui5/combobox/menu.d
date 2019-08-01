module uim.vue.vueui5.combobox.menu;

public import uim.vue;

static this() {
    uim.vue.vueui5.
    vueComboboxMenu = VUEComponent.
        templ(`
<fd-menu @select="selectItem">
    <slot />
  </fd-menu>        `)
        .script(`
import FdMenu from "./../Menu/Menu.vue";
export default {
  name: "FdComboboxMenu",
  inject: ["combobox"],
  components: { FdMenu },
  methods: {
    selectItem(item) {
      this.combobox.selectItem(item);
    }
  }
};        `); 
}
unittest {
    
}
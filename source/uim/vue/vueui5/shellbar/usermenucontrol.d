module uim.vue.vueui5.shellbar.usermenucontrol;

public import uim.vue;

static this() {
    import uim.vue.vueui5;
    vueShellBarUserMenuControl = VUEComponent
      .script(`
import FdIdentifier from "./../../Identifier/Identifier.vue";

export default {
  name: "FdShellBarUserMenuControl",
  components: { FdIdentifier }
};`)
      .templ(`
<div class="fd-user-menu__control" role="button" v-on="$listeners">
    <slot>
      <fd-identifier size="s" backgroundColor="accent-6" circle icon="person-placeholder" />
    </slot>
  </div>`);
}
unittest {
    
}
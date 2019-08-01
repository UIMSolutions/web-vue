module uim.vue.vueui5.splitbutton.action;

public import uim.vue;

static this() {
     import uim.vue.vueui5.splitbutton;
    vueSplitButtonAction = VUEComponent
        .script(`
import FdButton from "./../Button/Button.vue";

export default {
  name: "FdSplitButtonAction",
  components: { FdButton },
  inject: ["splitButton"],
  computed: {
    state() {
      return this.splitButton.state;
    },
    type() {
      return this.splitButton.type;
    },
    styling() {
      return this.splitButton.styling;
    },
    compact() {
      return this.splitButton.disacompactbled;
    },
    icon() {
      return this.splitButton.icon;
    }
  }
};`)
        .templ(`
<fd-button
    v-bind="$attrs"
    v-on="$listeners"
    :state="state"
    :type="type"
    :styling="styling"
    :compact="compact"
    :icon="icon"
  >
    <slot />
  </fd-button>`);
}
unittest {
    
}
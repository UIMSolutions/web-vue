module uim.vue.vueui5.form.message;

public import uim.vue;

static this() {
    uim.vue.vueui5.
    vueFormMessage = VUEComponent.
        templ(`
<span :class="classes">
    <slot />
  </span>`)
        .script(`
const typeMapping = {
  error: "error",
  warning: "warning",
  help: "help"
};
const MessageTypes = Object.keys(typeMapping);
const isMessageType = value => MessageTypes.indexOf(value) >= 0;

export default {
  name: "FdFormMessage",
  props: {
    type: { default: null, type: String, validator: isMessageType }
  },
  computed: {
    classes() {
      const staticClass = "fd-form__message";
      return {
        [staticClass]: true,
        ['${staticClass}--${this.type || ""}']: this.type != null
      };
    }
  }
};`); 
}
unittest {
    
}
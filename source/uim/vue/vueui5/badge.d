module uim.vue.vueui5.badge;

public import uim.vue;

static this() {
    uim.vue.vueui5.
    vueBadge = VUEComponent.
        templ(`
  <span :class="classes">
    <!-- Badge content â€“ usually just plain text -->
    <slot />
  </span>
          `)
        .script(`
const BadgeTypes = ["warning", "error", "success"];
const BadgeTypeIsValid = value => BadgeTypes.indexOf(value) >= 0;

// Easily highlight the state of an object using a badge.
export default {
  name: "FdBadge",
  props: {
    // If 'true' the badge will be rendered with a more prominent background color.
    filled: {
      type: Boolean,
      default: false
    },
    // If 'true' the badge will be rendered with the maximum amount of roundness â€“ will look just like a pill.
    pill: {
      type: Boolean,
      default: false
    },
    // Type of badge to display.
    type: {
      // 'warning' / 'error' / 'success'
      type: String,
      // 'null' â€“ by default a neutral badge is rendered.
      default: null,
      validator: BadgeTypeIsValid
    }
  },
  computed: {
    classes() {
      const type = this.type == null ? {} : { ['fd-badge--${this.type}']: true };
      return {
        "fd-badge": true,
        "fd-badge--filled": this.filled,
        "fd-badge--pill": this.pill,
        ...type
      };
    }
  }
};        `); 
}
unittest {
}
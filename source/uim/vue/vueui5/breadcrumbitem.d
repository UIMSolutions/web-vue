module uim.vue.vueui5.breadcrumbitem;

public import uim.vue;

// A breadcrumb item renders a single items and is used in combination with `fd-breadcrumb`. All attributes will be passed down to the anchor-tag that is rendered on your behalf.
static this() {
    uim.vue.vueui5.
    vueBreadcrumbItem = VUEComponent.
        templ(`
<li class="fd-breadcrumb__item">
    <a class="fd-breadcrumb__link" @click="pushLocationIfPossible" v-bind="attrs" v-on="$listeners">
      <!-- Anchor tag content -->
      <slot />
    </a>
  </li>        `)
        .script(`
import { withTargetLocation } from "./../../mixins";
export default {
  name: "FdBreadcrumbItem",
  inheritAttrs: false,
  mixins: [withTargetLocation()],
  computed: {
    attrs() {
      return {
        href: "#",
        ...this.$attrs
      };
    }
  }
};        `); 
}
unittest {
    
}
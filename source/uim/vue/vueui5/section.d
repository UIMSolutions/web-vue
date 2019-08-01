module uim.vue.vueui5.section;

public import uim.vue;

static this() {
    import uim.vue.vueui5;
    vueSection = VUEComponent.
        templ(`
<section class="fd-section">
    <div class="fd-section__header" v-if="needsHeader">
      <slot name="title">
        <h1 class="fd-section__title">{{ title }}</h1>
      </slot>
    </div>
    <slot />
  </section>`)
        .script(`
export default {
  name: "FdSection",
  props: {
    title: { type: String, default: null }
  },
  computed: {
    needsHeader() {
      return this.$slots.title != null || this.title != null;
    }
  }
};`); 
}
unittest {
    
}
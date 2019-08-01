module uim.vue.vueui5.breadcrumb;

public import uim.vue;

// The breadcrumb allows users to see the current page and navigation path to that page.
static this() {
    uim.vue.vueui5.
    vueBreadcrumb = VUEComponent.
        templ(`
<ul class="fd-breadcrumb">
    <!-- one or more 'fd-breadcrumb-item''s -->
    <slot />
</ul>
  `)
        .script(`
export default {
    name: "FdBreadcrumb"
};
    `); 
}

unittest {
}
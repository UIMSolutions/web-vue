module uim.vue.vueui5.tile.content;

public import uim.vue;

static this() {
    import uim.vue.vueui5.tile;
    vueTileContent = VUEComponent
.script(`
export default { name: "FdTileContent" };
`)
.templ(`
<div class="fd-tile__content"><slot /></div>
`);
}
unittest {
    
}
module uim.vue.vueui5.tile.actions;

public import uim.vue;

static this() {
    import uim.vue.vueui5.tile;
    vueTileActions = VUEComponent
.script(`
export default { name: "FdTileActions" };
`)
.templ(`
<div class="fd-tile__actions"><slot /></div>
`);
}
unittest {
    
}
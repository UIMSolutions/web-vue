module uim.vue.vueui5.tile.media;

public import uim.vue;

static this() {
    import uim.vue.vueui5.tile;
    vueTileMedia = VUEComponent
        .script(`
  export default { name: "FdTileMedia" };`)
.templ(`
  <div class="fd-tile__media"><slot /></div>`);
}
unittest {
    
}
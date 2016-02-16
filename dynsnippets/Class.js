Ext.define('%%classname%%', {

    extend: 'parent',

    inject: {
        logger: 'logger'
    },

    loggerName: '%%classname%%',

    constructor: function(config) {
        this.initConfig(config);
        this.callParent(arguments);
    }
});

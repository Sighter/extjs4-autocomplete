
/**
 * this is the class description
 * @param  {[type]} 'Myapp.view.Panel' [description]
 * @param  {[type]} {                                             constructor: function(config) {                       this.initConfig(config);        this.callParent(arguments);    } [description]
 * @param  {[type]} myMethod:          function      (arg1, arg2) {                                }} [description]
 * @return {[type]}                    [description]
 */
Ext.define('Myapp.view.Panel', {

    constructor: function(config) {
        this.initConfig(config);
        this.callParent(arguments);
    },

    /**
     * this is the doc of myMethod
     *
     * @param  {String} arg1 some description
     * @param  {Object} arg2 hello
     * @return {String}      this is the return value
     */
    myMethod: function (arg1, arg2) {

    }
});

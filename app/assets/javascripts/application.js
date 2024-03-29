// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
// require bootstrap-sprockets
// require bootstrap
//= require bootstrap/modal
//= require bootstrap-datepicker
//= require bootstrap/dropdown
//= require bootstrap/alert
//= require bootstrap/collapse
//= require bootstrap/affix
// require slim
//= require_tree .


$(document).on('ready', function(){
    $('.datepicker').datepicker({
        format: "yyyy-mm-dd",
        weekStart: 1,
        language: locale
    });

    $('.datepicker-months').datepicker({ 
        format: "yyyy-mm",
        viewMode: "months", 
        minViewMode: "months",
        language: locale
    });
    setupCategorySelect();
})
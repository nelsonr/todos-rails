// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.api.fnReloadAjax
//= require dataTables/jquery.dataTables.bootstrap
//= require_tree .

$(function() {
    var dtable, timer;

    if ($('.datatable-todos').length) {
        dtable = $('.datatable-todos').dataTable({
            "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "sPaginationType": "bootstrap",
            "bProcessing": true,
            "bServerSide": true,
            "sAjaxSource": $('[data-source]').val(),
            "fnRowCallback": function(nRow, aData) {
                var link = '<a href="'+ aData[3] +'">' + aData[0] + '</a>';

                $('td:eq(0)', nRow).html(link);

                return nRow;
            }
        });
    }

    $('.datatable-tasks').dataTable({
        "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sPaginationType": "bootstrap"
    });

    if (dtable) {
        // Reload table every 5 seconds
        timer = setInterval(function() {
            dtable.fnReloadAjax();
        }, 5000);
    }

    // Remove data table class
    $('.dataTable').removeClass('dataTable');
});


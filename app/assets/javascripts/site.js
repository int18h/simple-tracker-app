$(document).ready(function () {
    $('#search-issue-id').selectize({
        plugins: ['remove_button'],
        delimiter: ',',
        persist: false,
        valueField: 'id',
        labelField: 'name',
        searchField: 'name',
        options: [],
        create: false,
        load: function(query, callback) {
            // if (query.length < 3) return callback();
            $.ajax({
                url: '/searchissue',
                type: 'GET',
                dataType: 'json',
                data: {
                    q: query,
                },
                error: function() {
                    callback();
                },
                success: function(res) {
                    callback(res);
                }
            });
        }
    });
});

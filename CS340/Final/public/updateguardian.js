function updateGuardian(id){
    $.ajax({
        url: '/guardian/' + id,
        type: 'PUT',
        data: $('#update-guardian').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};

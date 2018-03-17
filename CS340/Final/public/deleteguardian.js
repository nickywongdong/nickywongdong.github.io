function deleteGuardian(id){
    $.ajax({
        url: '/guardian/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};

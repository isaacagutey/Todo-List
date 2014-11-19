$(document).ready(function(){
    $('img').click( function(){
        var id=$(this).data('id');
        $('#item'+id).remove();
        $.ajax('/'+id,{
            type:'delete'
        })
    });

    $('#add').on('submit',function(e){
       e.preventDefault();
        $.ajax('/',{
            type:'post',
            data:{ "content": $('#new_todo').val()},
            success: function(result){
                $('header').remove();
//                $('.list,#add').remove();
                $('#main').html(result)
            }
        });
    });
});


console.log('Form.js loaded')

function store() {
    const form = document.querySelector("#formfeedback");
    $.ajax({
        url: 'feedback/cadastrar',
        type: 'POST',
        contentType : false,
        processData: false,
        data: new FormData(form),
        success: function(response) {
            alert('Feedback cadastrado com sucesso!');
            $('#titulo').val('');
            $('#tipo').val('');
            $('#descricao').val('');
        },
        error: function(error) {
            alert('Erro ao cadastrar o feedback!' + error.responseText);
        }
    });
}
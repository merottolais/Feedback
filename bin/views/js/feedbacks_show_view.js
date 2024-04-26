console.log('update.js loaded');

let feedbackId = 0;

$(document).ready(function() {
    setFeedbackId()
    obterFeedback()
})

function setFeedbackId() {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    feedbackId = urlParams.get('id');
}

function obterFeedback() {
    $.ajax({
        url: 'feedbacks/' + feedbackId,
        type: 'GET',
        headers: {
            "Authorization": getLoginToken()
        },
        success: function(response) {
            console.log(response)
            feedback = response.data
            $('#titulo').text(feedback.titulo)
            $('#descricao').text(feedback.descricao)
            $('#status').val(feedback.status)
        },
        error: function(error) {
            alert('Erro ao obter o feedback!' + error.responseText);
        }
    })
}

function atualizar() {
    var status = $('#status').val()
    $.ajax({
        url: 'feedback/atualizar/' + feedbackId + '?status=' + status,
        type: 'PUT',
        contentType: false,
        processData: false,
        headers: {
            "Authorization": getLoginToken()
        },
        success: function (response) {
            alert('Feedback atualizado com sucesso!');
        },
        error: function (error) {
            alert('Erro ao atualizar o feedback!' + error.responseText);
        }
    });
}
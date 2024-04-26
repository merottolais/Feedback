console.log('list.js loaded');

$(document).ready(function() {
    getAllfeedbacks()
})

function getAllfeedbacks() {
    $.ajax({
        url: 'feedbacks',
        type: 'GET',
        headers: {
            "Authorization": getLoginToken()
        },
        success: function(response) {
            console.log(response)
            populateFeedbacks(response.data)
        },
        error: function(error) {
            alert('Erro ao obter os feedbacks!' + error.responseText);
        }
    })
}

function populateFeedbacks(data) {
    data.forEach(feedback => {
        const tableRow = document.createElement('tr');
        tableRow.innerHTML = `
            <td>${feedback.id}</td>
            <td>${feedback.titulo}</td>
            <td>${feedback.tipo}</td>
            <td>${resolveStatus(feedback.status)}</td>
            <td><a href="/feedbacks_show_view.html?id=${feedback.id}" class="btn btn-info">Detalhes</a></td>
          `;
        document.getElementById('tableBody').appendChild(tableRow);
    });
}

function resolveStatus(status) {
    switch(status) {
        case 'recebido':
            return 'Recebido';
        case 'em_analise':
            return 'Em Análise';
        case 'em_desenvolvimento':
            return 'Em Desenvolvimento';
        case 'finalizado':
            return 'Finalizado';
        default:
            return 'Status Inválido';
    }
}
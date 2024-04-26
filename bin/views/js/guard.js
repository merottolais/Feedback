const tokenCookieName = 'feedbackTokenCookie';

$(document).ready(function() {
    if(window.location.pathname !== '/' && window.location.pathname !== '/formulario_view.html' && window.location.hash !== '#') {
        let token = getLoginToken();
        if(!token) {
            showLoginModal()
        }
    }
})

function showLoginModal() {
    if($('#loginModal').length) {
        $('#loginModal').modal('show');
        return;
    }

    $.get('_login.html', function(response) {
        $('body').append(response);
        $('#loginModal').modal('show');
    });
}

function login() {
    const form = document.querySelector("#loginForm");
    $.ajax({
        url: 'login',
        type: 'POST',
        contentType : false,
        processData: false,
        data: new FormData(form),
        success: function(response) {
            setCookie(response);
            $('#loginModal').modal('hide');
            window.location.href = 'feedbacks_view.html';
        },
        error: function(error) {
            alert('Erro ao logar! ' + error.responseText);
        }
    });
}

function logout() {
    removeCookie();
    window.location.href = '/';
}


function getLoginToken() {
    return $.cookie(tokenCookieName);
}

function setCookie(token) {
    $.cookie(tokenCookieName, token);
}

function removeCookie() {
    $.removeCookie(tokenCookieName);
}


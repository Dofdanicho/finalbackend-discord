document.getElementById("createForm").addEventListener("submit", function (event) {
    event.preventDefault();
    create();
});

function create() {
    const data = {
        username: document.getElementById("username").value,
        password: document.getElementById("password").value,
        email: document.getElementById("email").value,
        firstname: document.getElementById("first_name").value,
        lastname: document.getElementById("last_name").value,

        date_of_birth:"2000/12/12", //document.getElementById("date_of_birth").value,
        phone_number: document.getElementById("phone_number").value,
        creation_date:"2023/12/12", //document.getElementById("creation_date").value,

        last_login:"2023/12/12", //document.getElementById("last_login").value,
        user_status_status_id:1, //document.getElementById("user_status_status_id").value,
        user_roles_role_id:1 //document.getElementById("user_roles_role_id").value,
       
    };

    fetch("http://127.0.0.1:5000/auth/nuevo_usuario", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        }, 
        body: JSON.stringify(data),
        credentials: 'include'
    })
    .then(response => {
        if (response.status === 201) {
            // Redirect to profile page if login is successful
            return response.json().then(data => {
                window.location.href = "login.html";
            });
        } else {
            return response.json().then(data => {
                document.getElementById("message").innerHTML = `<div class="notifications-container">
                <div class="error-alert">
                  <div class="flex">
                    <div class="flex-shrink-0">
                      <svg aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" class="error-svg">
                        <path clip-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" fill-rule="evenodd"></path>
                      </svg>
                    </div>
                    <div class="error-prompt-container">
                      <p class="error-prompt-heading">${data.message}</p>
                    </div>
                  </div>
                </div>
              </div>`;
            });
        }
    })
    .catch(error => {
        document.getElementById("message").innerHTML = "An error occurred.";
    });
}
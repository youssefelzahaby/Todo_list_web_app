
const API = "http://127.0.0.1:8000";

async function register() {

    const username = document.getElementById("username").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    const res = await fetch(`${API}/register/`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            username,
            email,
            password
        })
    });

    const data = await res.json();

    if (res.ok) {
        alert("Account created successfully");

        window.location.href = "task.html";

    } else {
        console.log(data);
        alert(JSON.stringify(data));
    }

}   


function toggleDark() {
    document.body.classList.toggle("dark");
}
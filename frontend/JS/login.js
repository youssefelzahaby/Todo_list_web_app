function toggleDark() {
    document.body.classList.toggle("dark");
}
async function login() {

    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    try {

        const res = await fetch(`${API_URL}/login/`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                username: username,
                password: password
            })
        });

        const data = await res.json();

        console.log("Response:", data);

        if (res.ok) {

            localStorage.setItem("access", data.access);
            localStorage.setItem("refresh", data.refresh);

            console.log("Saved Access:", localStorage.getItem("access"));

            window.location.href = "task.html";

        } else {

            alert(data.detail || "Login failed");
        }

    } catch (error) {

        console.error(error);
        alert("Server error");
    }
}
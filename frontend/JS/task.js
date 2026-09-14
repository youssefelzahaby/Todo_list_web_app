

/* ================= DARK MODE ================= */

function toggleDark() {
    document.body.classList.toggle("dark");
}

/* ================= CHECK LOGIN ================= */

window.onload = () => {

    const token = localStorage.getItem("access");

    if (!token) {
        window.location.href = "login.html";
        return;
    }

    getTasks();
};

/* ================= GET TASKS ================= */

async function getTasks() {

    const token = localStorage.getItem("access");

    try {

        const res = await fetch(`${API_URL}/tasks/`, {
            method: "GET",
            headers: {
                Authorization: `Bearer ${token}`
            }
        });

        const tasks = await res.json();

        const taskList = document.getElementById("taskList");

        taskList.innerHTML = "";

        tasks.forEach(task => {

            taskList.innerHTML += `
                <li>
                    <div>
                        <strong>${task.title}</strong>
                        <br>
                        ${task.description || ""}
                    </div>

                    <button onclick="deleteTask(${task.id})">
                        Delete
                    </button>
                </li>
            `;
        });

    } catch (error) {

        console.error(error);
        alert("Error loading tasks");
    }
}

/* ================= ADD TASK ================= */

async function addTask() {

    const token = localStorage.getItem("access");
    const input = document.getElementById("taskInput");

    const title = input.value.trim();

    // 1) Check login
    if (!token) {
        alert("You are not logged in");
        window.location.href = "login.html";
        return;
    }

    // 2) Check empty input
    if (!title) {
        alert("Enter task title");
        return;
    }

    try {

        const res = await fetch(`${API_URL}/tasks/create/`, {

            method: "POST",

            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${token}`
            },

            body: JSON.stringify({
                title: title,
                description: "",
                completed: false
            })
        });

        // 3) Parse response
        const data = await res.json();

        console.log("STATUS:", res.status);
        console.log("RESPONSE:", data);

        // 4) Success
        if (res.ok) {

            input.value = "";
            getTasks();

        } else {

            // 🔥 IMPORTANT: show real Django error
            alert(
                data?.detail ||
                data?.title?.[0] ||
                "Failed to create task"
            );

            console.log("Backend Error:", data);
        }

    } catch (error) {

        console.error("Network Error:", error);
        alert("Server error");
    }
}

/* ================= DELETE TASK ================= */

async function deleteTask(id) {

    const token = localStorage.getItem("access");

    try {

        const res = await fetch(
            `${API_URL}/tasks/delete/${id}/`,
            {
                method: "DELETE",

                headers: {
                    Authorization: `Bearer ${token}`
                }
            }
        );

        if (res.ok) {

            getTasks();

        } else {

            alert("Failed to delete task");
        }

    } catch (error) {

        console.error(error);
    }
}

/* ================= LOGOUT ================= */

function logout() {

    localStorage.removeItem("access");
    localStorage.removeItem("refresh");

    window.location.href = "login.html";
}



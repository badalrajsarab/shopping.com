<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<div class="modal modal-sheet position-static d-block bg-body-secondary p-4 py-md-5" tabindex="-1" role="dialog" id="modalSignin">
    <div class="modal-dialog" role="document">
        <div class="modal-content rounded-3 shadow">
            <div class="modal-header p-4 pb-2 border-bottom-0"></div>

            <div class="modal-body p-5 pt-5">
                <form action="login.jsp" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control rounded-3" id="floatingInput" name="name" placeholder="name@example.com" fdprocessedid="zy9pxn">
                        <label for="floatingInput">Name</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control rounded-3" id="floatingPassword" name="password" placeholder="Password" fdprocessedid="socwr">
                        <label for="floatingPassword">Password</label>
                    </div>
                    <button class="w-100 mb-2 btn btn-lg rounded-3 btn-custom" type="submit" fdprocessedid="lcn1ya">Log In</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%
String name = request.getParameter("name");
String password = request.getParameter("password");

if (name != null && password != null) {
    if (name.equals("Badal Raj") && password.equals("Badal123")) {
        response.sendRedirect("biscuits.jsp");
    } else if (name.equals("Admin") && password.equals("Admin123")) {
        response.sendRedirect("adbiscuits.jsp");
    } else {
%>
<script>
    alert("Invalid username or password.");
</script>
<%
}
}
%>

<style>
.bg-body-secondary {
    background-image: url("https://images.hdqwalls.com/wallpapers/abstract-simple-background-4k-lp.jpg");
    background-size: cover;
    background-repeat: no-repeat;
    height: 100vh;
}

.py-md-5 {
    padding-top: 7rem !important;
    padding-bottom: 3rem !important;
}

.modal-content {
    background-color: #fc39fb1c;
}

.btn-custom {
    background-color: #f8b400; 
    color: #fff; 
}

.btn-custom:hover {
    background-color: #e69900; 
}
</style>

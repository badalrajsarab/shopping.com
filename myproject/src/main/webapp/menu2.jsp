<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<nav class="navbar navbar-expand-lg navbar-light bg-light"
	style="background-color: rgb(203, 144, 238) !important;">
	<div class="container px-4 px-lg-5">
		<a class="navbar-brand" href="biscuits.jsp"><i
			class="fa-regular fa-compass fa-shake fa-xl"></i></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
				<li class="nav-item"></li>
				<li class="nav-item"><a class="nav-link" href="adbiscuits.jsp">BISCUIT</a></li>
				<li class="nav-item"><a class="nav-link" href="adsoap.jsp">SOAP</a></li>
				<li class="nav-item"><a class="nav-link" href="choco.jsp">CHOCOLATE</a></li>
				<li class="nav-item"><a class="nav-link" href="offerzone2.jsp">OFFER
						ZONE</a></li>
							<li class="nav-item"><a class="nav-link" href="edit.jsp">EDIT
						SLIDER</a></li>
				<li class="nav-item"><a class="nav-link" href="addProduct.jsp">ADD
						PRODUCT</a></li>
			</ul>
			<button type="button" id="logoutBtn"
				class="btn btn-outline-primary me-2" style="color: black;">LogOut</button>

		</div>
	</div>
</nav>
<script>
	document.getElementById("logoutBtn").addEventListener("click", function() {
		window.location.href = "login.jsp";
	});
</script>
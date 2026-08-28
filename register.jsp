<!DOCTYPE html>
<html>

<head>

	<meta charset="UTF-8">

	<title>Register | DisasterGuard AI</title>

	<style>
		body {

			margin: 0;

			font-family: Arial, sans-serif;

			background: #0f172a;

			color: white;

		}


		/* NAVBAR */

		.navbar {

			padding: 20px 60px;

			display: flex;

			justify-content: space-between;

			align-items: center;

			background: #111827;

		}


		.logo {

			font-size: 24px;

			font-weight: bold;

		}


		.logo span {

			color: #38bdf8;

		}


		.nav-buttons a {

			text-decoration: none;

			color: white;

			margin-left: 20px;

			padding: 10px 20px;

			border-radius: 6px;

		}


		.home {

			border: 1px solid #64748b;

		}


		.login {

			background: #2563eb;

		}


		/* REGISTER SECTION */

		.register-section {

			min-height: 80vh;

			display: flex;

			justify-content: center;

			align-items: center;

		}


		.register-container {

			width: 450px;

			background: #1e293b;

			padding: 40px;

			border-radius: 12px;

			box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);

		}


		.register-container h1 {

			text-align: center;

			font-size: 36px;

			margin-bottom: 10px;

		}


		.register-container h1 span {

			color: #38bdf8;

		}


		.register-container p {

			text-align: center;

			color: #cbd5e1;

			margin-bottom: 30px;

		}


		/* FORM */

		.form-group {

			margin-bottom: 18px;

		}


		.form-group label {

			display: block;

			margin-bottom: 8px;

			color: #cbd5e1;

		}


		.form-group input,

		.form-group select {

			width: 100%;

			padding: 13px;

			border: 1px solid #64748b;

			border-radius: 6px;

			background: #0f172a;

			color: white;

			font-size: 16px;

			box-sizing: border-box;

		}


		.form-group input:focus,

		.form-group select:focus {

			outline: none;

			border-color: #38bdf8;

		}


		/* REGISTER BUTTON */

		.register-button {

			width: 100%;

			padding: 14px;

			border: none;

			border-radius: 6px;

			background: #2563eb;

			color: white;

			font-size: 16px;

			font-weight: bold;

			cursor: pointer;

		}


		.register-button:hover {

			background: #1d4ed8;

		}


		/* LOGIN LINK */

		.login-text {

			text-align: center;

			margin-top: 25px;

			color: #cbd5e1;

		}


		.login-text a {

			color: #38bdf8;

			text-decoration: none;

			font-weight: bold;

		}


		/* FEATURES */

		.register-features {

			display: flex;

			justify-content: center;

			gap: 20px;

			margin-top: 25px;

		}


		.small-feature {

			background: #111827;

			padding: 15px;

			border-radius: 8px;

			text-align: center;

			width: 120px;

		}


		.small-feature h4 {

			color: #38bdf8;

			margin: 5px 0;

		}


		.small-feature p {

			font-size: 12px;

			margin: 0;

		}
	</style>

</head>


<body>


	<!-- NAVBAR -->

	<div class="navbar">


		<div class="logo">

			DisasterGuard <span>AI</span>

		</div>


		<div class="nav-buttons">


			<a href="index.jsp" class="home">

				Home

			</a>


			<a href="login.jsp" class="login">

				Login

			</a>


		</div>


	</div>



	<!-- REGISTER SECTION -->

	<div class="register-section">


		<div>


			<div class="register-container">


				<h1>

					Join <span>DisasterGuard AI.</span>

				</h1>


				<p>

					Create your account and access

					intelligent disaster management.

				</p>


				<form action="<%= request.getContextPath() %>/RegisterServlet" method="post">


					<div class="form-group">


						<label>

							Full Name

						</label>


						<input type="text" name="name" placeholder="Enter your full name" required>


					</div>



					<div class="form-group">


						<label>

							Email Address

						</label>


						<input type="email" name="email" placeholder="Enter your email" required>


					</div>



					<div class="form-group">


						<label>

							Password

						</label>


						<input type="password" name="password" placeholder="Create a password" required>


					</div>







					<button type="submit" class="register-button">


						Create DisasterGuard Account


					</button>


				</form>



				<div class="login-text">


					Already have an account?


					<a href="login.jsp">

						Sign In

					</a>


				</div>


			</div>



			<!-- PRODUCT FEATURES -->

			<div class="register-features">


				<div class="small-feature">


					<h4>AI</h4>


					<p>

						Risk Prediction

					</p>


				</div>



				<div class="small-feature">


					<h4>LIVE</h4>


					<p>

						Risk Monitoring

					</p>


				</div>



				<div class="small-feature">


					<h4>24/7</h4>


					<p>

						Emergency Support

					</p>


				</div>


			</div>


		</div>


	</div>


</body>

</html>
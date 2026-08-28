<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!DOCTYPE html>
	<html>

	<head>

		<meta charset="UTF-8">

		<title>Login | DisasterGuard AI</title>

		<style>
			* {
				box-sizing: border-box;
			}

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


			.register {

				background: #2563eb;

			}


			/* LOGIN SECTION */

			.login-section {

				min-height: 80vh;

				display: flex;

				justify-content: center;

				align-items: center;

			}


			.login-container {

				width: 420px;

				background: #1e293b;

				padding: 40px;

				border-radius: 12px;

				box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);

			}


			.login-container h1 {

				text-align: center;

				font-size: 36px;

				margin-bottom: 10px;

			}


			.login-container h1 span {

				color: #38bdf8;

			}


			.login-container p {

				text-align: center;

				color: #cbd5e1;

				margin-bottom: 30px;

			}


			/* ERROR MESSAGE */

			.error-message {

				background: #7f1d1d;

				color: #fecaca;

				padding: 12px;

				border-radius: 6px;

				text-align: center;

				margin-bottom: 20px;

			}

			/* SUCCESS MESSAGE */

			.success-message {

				background: #14532d;

				color: #bbf7d0;

				padding: 12px;

				border-radius: 6px;

				text-align: center;

				margin-bottom: 20px;

				border: 1px solid #22c55e;

				font-weight: bold;

			}


			/* FORM */

			.form-group {

				margin-bottom: 20px;

			}


			.form-group label {

				display: block;

				margin-bottom: 8px;

				color: #cbd5e1;

			}


			.form-group input {

				width: 100%;

				padding: 13px;

				border: 1px solid #64748b;

				border-radius: 6px;

				background: #0f172a;

				color: white;

				font-size: 16px;

			}


			.form-group input:focus {

				outline: none;

				border-color: #38bdf8;

			}


			.login-button {

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


			.login-button:hover {

				background: #1d4ed8;

			}


			/* REGISTER LINK */

			.register-text {

				text-align: center;

				margin-top: 25px;

				color: #cbd5e1;

			}


			.register-text a {

				color: #38bdf8;

				text-decoration: none;

				font-weight: bold;

			}


			/* FEATURES */

			.login-features {

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


			/* MOBILE */

			@media (max-width: 600px) {

				.navbar {

					padding: 20px;

				}

				.login-container {

					width: 90%;

				}

				.login-features {

					gap: 8px;

				}

				.small-feature {

					width: 100px;

				}

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


				<a href="<%= request.getContextPath() %>/index.jsp" class="home">

					Home

				</a>


				<a href="<%= request.getContextPath() %>/register.jsp" class="register">

					Register

				</a>


			</div>


		</div>


		<!-- LOGIN SECTION -->

		<div class="login-section">


			<div>


				<div class="login-container">


					<h1>

						Welcome <span>Back.</span>

					</h1>


					<p>

						Access your intelligent disaster

						management platform.

					</p>


					<!-- SHOW ERROR ONLY WHEN LOGIN FAILS -->

					<p>

						Access your intelligent disaster

						management platform.

					</p>
					<% if ("success".equals(request.getParameter("registered"))) { %>

						<div class="success-message">

							✅ Registration Successful! Please login with your email and password.

						</div>

						<% } %>

							<% if ("invalid".equals(request.getParameter("error"))) { %>

								<div class="error-message">

									❌ Invalid email or password.

								</div>

								<% } %>


									<!-- LOGIN FORM -->

									<form action="<%= request.getContextPath() %>/LoginServlet" method="post">


										<div class="form-group">


											<label>Email</label>


											<input type="email" name="email" placeholder="Enter your email" required>


										</div>


										<div class="form-group">


											<label>Password</label>


											<input type="password" name="password" placeholder="Enter your password"
												required>


										</div>


										<button type="submit" class="login-button">


											Sign In


										</button>


									</form>


									<div class="register-text">


										Don't have an account?


										<a href="<%= request.getContextPath() %>/register.jsp">

											Create Account

										</a>


									</div>


				</div>


				<!-- PRODUCT FEATURES -->

				<div class="login-features">


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
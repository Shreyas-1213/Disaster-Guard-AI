<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>DisasterGuard AI</title>

	<style>
		body {
			margin: 0;
			font-family: Arial, sans-serif;
			background: #0f172a;
			color: white;
		}

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

		.nav-buttons a {
			text-decoration: none;
			color: white;
			margin-left: 20px;
			padding: 10px 20px;
			border-radius: 6px;
		}

		.login {
			background: #2563eb;
		}

		.register {
			border: 1px solid #64748b;
		}

		.hero {
			min-height: 80vh;
			display: flex;
			align-items: center;
			justify-content: center;
			text-align: center;
		}

		.hero-content {
			max-width: 800px;
		}

		h1 {
			font-size: 58px;
			margin-bottom: 20px;
		}

		h1 span {
			color: #38bdf8;
		}

		p {
			font-size: 20px;
			color: #cbd5e1;
			line-height: 1.6;
		}

		.buttons {
			margin-top: 30px;
		}

		.btn {
			display: inline-block;
			padding: 15px 30px;
			margin: 10px;
			text-decoration: none;
			border-radius: 8px;
			font-weight: bold;
		}

		.primary {
			background: #2563eb;
			color: white;
		}

		.secondary {
			border: 1px solid #64748b;
			color: white;
		}

		.features {
			display: flex;
			justify-content: center;
			gap: 25px;
			margin-top: 30px;
		}

		.feature {
			background: #1e293b;
			padding: 20px;
			width: 200px;
			border-radius: 10px;
		}
	</style>
</head>

<body>

	<div class="navbar">

		<div class="logo">
			DisasterGuard AI
		</div>

		<div class="nav-buttons">
			<a href="login.jsp" class="login">Login</a>
			<a href="register.jsp" class="register">Register</a>
		</div>

	</div>

	<div class="hero">

		<div class="hero-content">

			<h1>
				Predict Disasters.
				<span>Protect Communities.</span>
			</h1>

			<p>
				An AI-powered disaster risk prediction and emergency
				management system designed to provide early warnings,
				intelligent analysis, and emergency response support.
			</p>

			<div class="buttons">
				<a href="register.jsp">
					Get Started
				</a>

				<a href="login.jsp">
					Login
				</a>
			</div>

			<div class="features">

				<div class="feature">

					<h3>AI Prediction</h3>
					<p>Predict disaster risks using machine learning.</p>
				</div>

				<div class="feature">

					<h3>Early Alerts</h3>
					<p>Receive alerts for high-risk conditions.</p>
				</div>

				<div class="feature">

					<h3>Emergency Response</h3>
					<p>Find shelters and emergency resources.</p>
				</div>

			</div>

		</div>

	</div>

</body>

</html>
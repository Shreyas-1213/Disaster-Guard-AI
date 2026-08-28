<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<% if(session.getAttribute("user")==null){ response.sendRedirect("login.jsp"); return; } %>

		<!DOCTYPE html>
		<html>

		<head>

			<meta charset="UTF-8">

			<title>AI Risk Prediction | DisasterGuard AI</title>

			<style>
				body {
					margin: 0;
					font-family: Arial, sans-serif;
					background: #0f172a;
					color: white;
				}

				.navbar {

					background: #111827;
					padding: 20px 60px;
					display: flex;
					justify-content: space-between;
					align-items: center;
				}

				.logo {

					font-size: 24px;
					font-weight: bold;
				}

				.logo span {

					color: #38bdf8;
				}

				.container {

					width: 700px;
					margin: 40px auto;
					background: #1e293b;
					padding: 40px;
					border-radius: 12px;
				}

				.container h1 {

					text-align: center;
					margin-bottom: 30px;
				}

				.form-group {

					margin-bottom: 20px;
				}

				label {

					display: block;
					margin-bottom: 8px;
				}

				input,
				select {

					width: 100%;
					padding: 12px;
					border: none;
					border-radius: 6px;
					background: #0f172a;
					color: white;
				}

				button {

					width: 100%;
					padding: 15px;
					background: #2563eb;
					color: white;
					border: none;
					border-radius: 6px;
					font-size: 18px;
					cursor: pointer;
				}

				button:hover {

					background: #1d4ed8;
				}
			</style>

		</head>

		<body>

			<div class="navbar">

				<div class="logo">

					DisasterGuard <span>AI</span>

				</div>

			</div>

			<div class="container">

				<h1>AI Disaster Risk Prediction</h1>

				<form action="PredictionServlet" method="post">

					<div class="form-group">

						<label>Location</label>

						<input type="text" name="location" required>

					</div>

					<div class="form-group">

						<label>Disaster Type</label>

						<select name="disasterType">

							<option>Flood</option>

							<option>Cyclone</option>

							<option>Earthquake</option>

							<option>Landslide</option>

							<option>Drought</option>

						</select>

					</div>

					<div class="form-group">

						<label>Rainfall (mm)</label>

						<input type="number" step="0.1" name="rainfall" required>

					</div>

					<div class="form-group">

						<label>Temperature (°C)</label>

						<input type="number" step="0.1" name="temperature" required>

					</div>

					<div class="form-group">

						<label>Humidity (%)</label>

						<input type="number" step="0.1" name="humidity" required>

					</div>

					<div class="form-group">

						<label>Wind Speed (km/h)</label>

						<input type="number" step="0.1" name="windSpeed" required>

					</div>

					<button type="submit">

						Predict Risk

					</button>

				</form>

			</div>

		</body>

		</html>
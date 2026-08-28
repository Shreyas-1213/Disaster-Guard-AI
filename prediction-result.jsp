<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ page import="com.disaster.model.Prediction" %>

		<% Prediction prediction=(Prediction) request.getAttribute("prediction"); if (prediction==null) {
			response.sendRedirect("risk-prediction.jsp"); return; } %>

			<!DOCTYPE html>
			<html>

			<head>

				<meta charset="UTF-8">

				<title>Prediction Result | DisasterGuard AI</title>

				<style>
					body {
						margin: 0;
						font-family: Arial, sans-serif;
						background: #0f172a;
						color: white;
					}

					.container {

						width: 700px;
						margin: 40px auto;
						background: #1e293b;
						padding: 40px;
						border-radius: 12px;
					}

					h1 {

						text-align: center;
						color: #38bdf8;
					}

					table {

						width: 100%;
						border-collapse: collapse;
						margin-top: 25px;
					}

					td {

						padding: 14px;
						border-bottom: 1px solid #334155;
					}

					.label {

						font-weight: bold;
						color: #38bdf8;
					}

					.result {

						margin-top: 30px;
						text-align: center;
					}

					.high {

						color: red;
						font-size: 28px;
						font-weight: bold;
					}

					.medium {

						color: orange;
						font-size: 28px;
						font-weight: bold;
					}

					.low {

						color: lightgreen;
						font-size: 28px;
						font-weight: bold;
					}

					.button {

						display: inline-block;
						margin-top: 30px;
						padding: 14px 25px;
						background: #2563eb;
						color: white;
						text-decoration: none;
						border-radius: 6px;
					}
				</style>

			</head>

			<body>

				<div class="container">

					<h1>AI Prediction Result</h1>

					<table>

						<tr>
							<td class="label">Location</td>
							<td>
								<%= prediction.getLocation() %>
							</td>
						</tr>

						<tr>
							<td class="label">Disaster Type</td>
							<td>
								<%= prediction.getDisasterType() %>
							</td>
						</tr>

						<tr>
							<td class="label">Rainfall</td>
							<td>
								<%= prediction.getRainfall() %> mm
							</td>
						</tr>

						<tr>
							<td class="label">Temperature</td>
							<td>
								<%= prediction.getTemperature() %> °C
							</td>
						</tr>

						<tr>
							<td class="label">Humidity</td>
							<td>
								<%= prediction.getHumidity() %> %
							</td>
						</tr>

						<tr>
							<td class="label">Wind Speed</td>
							<td>
								<%= prediction.getWindSpeed() %> km/h
							</td>
						</tr>

					</table>

					<div class="result">

						<h2>Predicted Risk Level</h2>

						<% String risk=prediction.getRiskLevel(); if("HIGH".equals(risk)){ %>

							<div class="high">HIGH RISK</div>

							<% } else if("MEDIUM".equals(risk)){ %>

								<div class="medium">MEDIUM RISK</div>

								<% } else{ %>

									<div class="low">LOW RISK</div>

									<% } %>

										<a href="dashboard.jsp" class="button">

											Back to Dashboard

										</a>

					</div>

				</div>

			</body>

			</html>
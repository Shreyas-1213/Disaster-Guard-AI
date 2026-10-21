
package com.disaster.controller;

import java.io.IOException;

import com.disaster.intelligence.GeminiService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AIDisasterAssistantServlet")
public class AIDisasterAssistantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final GeminiService geminiService = new GeminiService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        request.getRequestDispatcher("/ai-assistant.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Your session has expired. Please log in again.");
            return;
        }

        String question = request.getParameter("question");

        if (question == null || question.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Please enter a question.");
            return;
        }

        if (question.length() > 2000) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Please keep your question under 2000 characters.");
            return;
        }

        try {
            String answer = geminiService.getResponse(question);
            response.getWriter().write(answer);

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            response.getWriter().write("The assistant was interrupted. Please try again.");

        } catch (IOException e) {
            getServletContext().log("Gemini API request failed.", e);
            response.setStatus(HttpServletResponse.SC_BAD_GATEWAY);
            response.getWriter().write(
                "The AI assistant could not respond. Check the server log and try again."
            );

        } catch (IllegalStateException e) {
            getServletContext().log("Gemini configuration error.", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(
                "The AI assistant is not configured correctly. Check the server environment."
            );
        }
    }
}

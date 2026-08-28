package com.disaster.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.disaster.dao.UserDAO;
import com.disaster.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt: " + email);

        UserDAO userDAO = new UserDAO();

        User user = userDAO.loginUser(email, password);

        if (user != null) {

            System.out.println("Login successful");

            HttpSession session = request.getSession();

            session.setAttribute("user", user);

            // IMPORTANT
            response.sendRedirect(
                request.getContextPath() + "/dashboard.jsp"
            );

        } else {

            System.out.println("Invalid login credentials");

            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=invalid"
            );
        }
    }
}
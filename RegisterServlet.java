package com.disaster.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.disaster.dao.UserDAO;
import com.disaster.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User user =
                new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        UserDAO userDAO =
                new UserDAO();

        boolean registered =
                userDAO.registerUser(user);
        System.out.println("Register button clicked");

        if(registered){
            System.out.println("User Registered Successfully");
        }else{
            System.out.println("User Registration Failed");
        }

        if (registered) {

            System.out.println(
                    "Registration successful"
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?registered=success"
            );

        } else {

            System.out.println(
                    "Registration failed"
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=failed"
            );
        }
    }
}
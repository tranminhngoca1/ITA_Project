/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;
import service.*;

/**
 *
 * @author Dell
 */
public class IngredientController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet IngredientController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet IngredientController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private IngredientService service = new IngredientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<Ingredient> list = service.getAll();
            request.setAttribute("list", list);
            request.getRequestDispatcher("ingredient-list.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.getRequestDispatcher("ingredient-add.jsp").forward(request, response);
        } else if ("edit".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("ingredient", service.getById(id));
            request.getRequestDispatcher("ingredient-edit.jsp").forward(request, response);

        } else if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            service.delete(id);
            response.sendRedirect(request.getContextPath() + "/ingredient?action=list");
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {

            Ingredient i = new Ingredient();
            i.setName(request.getParameter("name"));
            i.setStockQuantity(Double.parseDouble(request.getParameter("stockQuantity")));
            i.setUnitID(Integer.parseInt(request.getParameter("unitID")));
            i.setSupplierID(Integer.parseInt(request.getParameter("supplierID")));

            service.insert(i);
            response.sendRedirect(request.getContextPath() + "/ingredient?action=list");

        } else if ("update".equals(action)) {

            Ingredient i = new Ingredient();
            i.setIngredientID(Integer.parseInt(request.getParameter("id")));
            i.setName(request.getParameter("name"));
            i.setStockQuantity(Double.parseDouble(request.getParameter("stockQuantity")));
            i.setUnitID(Integer.parseInt(request.getParameter("unitID")));
            i.setSupplierID(Integer.parseInt(request.getParameter("supplierID")));

            service.update(i);
            response.sendRedirect(request.getContextPath() + "/ingredient?action=list");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

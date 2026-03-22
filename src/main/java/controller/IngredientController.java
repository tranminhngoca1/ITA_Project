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
            try {
                String name = request.getParameter("name");
                String stockStr = request.getParameter("stockQuantity");
                String unitStr = request.getParameter("unitID");
                String supStr = request.getParameter("supplierID");

                // 👉 VALIDATE
                if (name == null || name.trim().isEmpty()
                        || stockStr == null || stockStr.isEmpty()
                        || unitStr == null || unitStr.isEmpty()
                        || supStr == null || supStr.isEmpty()) {

                    throw new RuntimeException("Missing input");
                }

                double stock = Double.parseDouble(stockStr);
                int unitID = Integer.parseInt(unitStr);
                int supplierID = Integer.parseInt(supStr);
                boolean isActive = request.getParameter("isActive") != null;

                Ingredient i = new Ingredient();
                i.setName(name);
                i.setStockQuantity(stock);
                i.setUnitID(unitID);
                i.setSupplierID(supplierID);
                i.setIsActive(isActive);

                service.insert(i);

            } catch (Exception e) {
                e.printStackTrace();
            }

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

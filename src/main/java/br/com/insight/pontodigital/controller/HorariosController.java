package br.com.insight.pontodigital.controller;

import br.com.insight.pontodigital.bean.PontoBean;
import br.com.insight.pontodigital.dao.PontoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/horarios")
public class HorariosController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String entrada = req.getParameter("entradaHorarios");
        String saida = req.getParameter("saidaHorarios");

        PontoDAO pDAO = PontoDAO.getInstance();
        List<PontoBean> listHorarios = PontoDAO.listHorarios;

        if (listHorarios.size() > 2) { //já foram inseridos 3 registros
            resp.sendRedirect(req.getContextPath());
            return;
        }

        if (ControllerUtil.validarInsert(entrada, saida, listHorarios)) {
            PontoBean pb = new PontoBean(entrada, saida, 1L);
            pDAO.insert(pb);
        }

        resp.sendRedirect(req.getContextPath());
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPut(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }
}

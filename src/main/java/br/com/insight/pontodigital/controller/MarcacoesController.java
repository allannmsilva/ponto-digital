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

@WebServlet("/marcacoes")
public class MarcacoesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String entrada = req.getParameter("entradaMarcacoes");
        String saida = req.getParameter("saidaMarcacoes");

        PontoDAO pDAO = PontoDAO.getInstance();
        List<PontoBean> listMarcacoes = PontoDAO.listMarcacoes;

        if (ControllerUtil.validarInsert(entrada, saida, listMarcacoes)) {
            PontoBean pb = new PontoBean(entrada, saida, 2L);
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

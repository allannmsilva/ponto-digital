package br.com.insight.pontodigital.controller;

import br.com.insight.pontodigital.bean.PontoBean;
import br.com.insight.pontodigital.dao.PontoDAO;
import com.fasterxml.jackson.databind.ObjectMapper;
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

        if (req.getParameter("entradaMarcacoes") != null) {
            String entrada = req.getParameter("entradaMarcacoes");
            String saida = req.getParameter("saidaMarcacoes");

            PontoDAO pDAO = PontoDAO.getInstance();
            List<PontoBean> listMarcacoes = PontoDAO.listMarcacoes;

            if (ControllerUtil.validarInsert(entrada, saida, listMarcacoes)) {
                PontoBean pb = new PontoBean(entrada, saida, 2L);
                pDAO.insert(pb);
            }

            resp.sendRedirect(req.getContextPath());
            return;
        }

        if (req.getParameter("index") == null) {
            ObjectMapper objectMapper = new ObjectMapper();
            int index = objectMapper.readValue(req.getInputStream(), Integer.class) - 1;
            PontoDAO.listMarcacoes.remove(index);
            resp.sendRedirect(req.getContextPath());
            return;
        }

        ObjectMapper objectMapper = new ObjectMapper();
        PontoBean ponto = objectMapper.readValue(req.getInputStream(), PontoBean.class);
        int index = Integer.parseInt(req.getParameter("index")) - 1;
        ponto.setTipoTabela(2L);
        PontoDAO.listMarcacoes.set(index, ponto);
        resp.sendRedirect(req.getContextPath());
    }
}

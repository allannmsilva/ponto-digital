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

@WebServlet("/horarios")
public class HorariosController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getParameter("entradaHorarios") != null) {
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
            return;
        }

        if (req.getParameter("index") == null) {
            ObjectMapper objectMapper = new ObjectMapper();
            int index = objectMapper.readValue(req.getInputStream(), Integer.class) - 1;
            PontoDAO.listHorarios.remove(index);
            resp.sendRedirect(req.getContextPath());
            return;
        }

        ObjectMapper objectMapper = new ObjectMapper();
        PontoBean ponto = objectMapper.readValue(req.getInputStream(), PontoBean.class);
        int index = Integer.parseInt(req.getParameter("index")) - 1;
        ponto.setTipoTabela(1L);
        PontoDAO.listHorarios.set(index, ponto);
        resp.sendRedirect(req.getContextPath());
    }
}

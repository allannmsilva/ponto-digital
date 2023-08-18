package br.com.insight.pontodigital.dao;

import br.com.insight.pontodigital.bean.PontoBean;

import java.util.ArrayList;
import java.util.List;

public class PontoDAO {

    private static PontoDAO pontoDAO;

    private PontoDAO() {
        if (listHorarios == null) {
            listHorarios = new ArrayList<>();
        }
        if (listMarcacoes == null) {
            listMarcacoes = new ArrayList<>();
        }
    }

    public static PontoDAO getInstance() {
        if (pontoDAO == null) {
            pontoDAO = new PontoDAO();
            return pontoDAO;
        }

        return pontoDAO;
    }

    public static List<PontoBean> listHorarios;
    public static List<PontoBean> listMarcacoes;

    public void insert(PontoBean pontoBean) {
        if (pontoBean.getTipoTabela() == 1L) {
            listHorarios.add(pontoBean);
        } else {
            listMarcacoes.add(pontoBean);
        }
    }

//    public static void insert(PontoBean pontoBean) {
//        Session sessao = null;
//
//        try {
//            sessao = HibernateConfiguration.getSessionFactory().openSession();
//
//            sessao.beginTransaction();
//            sessao.save(pontoBean);
//            sessao.getTransaction().commit();
//
//            sessao.close();
//        } catch (HibernateException hex) {
//            if (sessao != null) {
//                sessao.getTransaction().rollback();
//                sessao.close();
//            }
//            throw new HibernateException(hex);
//        }
//    }
}

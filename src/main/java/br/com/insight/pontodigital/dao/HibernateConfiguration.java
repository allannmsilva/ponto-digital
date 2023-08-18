package br.com.insight.pontodigital.dao;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateConfiguration {

    private static final SessionFactory sessionFactory;

    static {
        try {
            // Cria a sessão de acordo com o arquivo de configuração (hibernate.cfg.xml)
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (HibernateException ex) {
            // Dispara a exceção em caso de erros
            System.err.println("Erro ao criar sessão!" + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}

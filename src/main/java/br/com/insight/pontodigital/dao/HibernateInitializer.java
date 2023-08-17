package br.com.insight.pontodigital.dao;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class HibernateInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // Iniciando sessão hibernate
        HibernateConfiguration.getSessionFactory().openSession();
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        HibernateConfiguration.getSessionFactory().close();
    }
}

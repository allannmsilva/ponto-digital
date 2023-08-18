package br.com.insight.pontodigital.controller;

import br.com.insight.pontodigital.bean.PontoBean;
import br.com.insight.pontodigital.dao.PontoDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public class ControllerUtil {

    protected static boolean validarInsert(String entrada, String saida, List<PontoBean> list) {
        if (entrada.length() < 5 || saida.length() < 5) { //form inválido
            return false;
        }

        if (entrada.compareTo(saida) >= 0) { //entrada após saída
            return false;
        }

        String existingEntrada;
        String existingSaida;

        for (PontoBean pb : list) {
            existingEntrada = pb.getEntrada(); //entrada da linha atual
            existingSaida = pb.getSaida(); //saída da linha atual

            if ((entrada.compareTo(existingEntrada) >= 0 && entrada.compareTo(existingSaida) <= 0) || //verificando entrada
                    (saida.compareTo(existingEntrada) >= 0 && saida.compareTo(existingSaida) <= 0) || //verificando saída
                    (entrada.compareTo(existingEntrada) <= 0 && saida.compareTo(existingSaida) >= 0)) { //verificando entrada e saída
                return false;
            }
        }

        return true;
    }
}

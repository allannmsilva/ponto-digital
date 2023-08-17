package br.com.insight.pontodigital.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class Ponto {

    @Id
    @GeneratedValue
    private Long codigo;

    @Column(length = 5, nullable = false)
    private String entrada;

    @Column(length = 5, nullable = false)
    private String saida;

    public Long getCodigo() {
        return codigo;
    }

    public String getEntrada() {
        return entrada;
    }

    public void setEntrada(String entrada) {
        this.entrada = entrada;
    }

    public String getSaida() {
        return saida;
    }

    public void setSaida(String saida) {
        this.saida = saida;
    }
}

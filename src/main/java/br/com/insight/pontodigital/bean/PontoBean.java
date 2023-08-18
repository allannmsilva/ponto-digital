package br.com.insight.pontodigital.bean;

public class PontoBean {

    private Long codigo;
    private String entrada;
    private String saida;
    private Long tipoTabela;

    public PontoBean() {
    }

    public PontoBean(String entrada, String saida) {
        this.entrada = entrada;
        this.saida = saida;
    }

    public PontoBean(String entrada, String saida, Long tipoTabela) {
        this.entrada = entrada;
        this.saida = saida;
        this.tipoTabela = tipoTabela;
    }

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

    public Long getTipoTabela() {
        return tipoTabela;
    }

    public void setTipoTabela(Long tipoTabela) {
        this.tipoTabela = tipoTabela;
    }

}

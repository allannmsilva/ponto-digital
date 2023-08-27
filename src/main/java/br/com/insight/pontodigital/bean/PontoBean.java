package br.com.insight.pontodigital.bean;

public class PontoBean {

    private Long codigo;
    private String entrada;
    private String saida;
    private Long tipoTabela;
    private boolean mudaDia;

    public PontoBean() {

    }

    public PontoBean(String entrada, String saida, Long tipoTabela) {
        this.entrada = entrada;
        this.saida = saida;
        this.tipoTabela = tipoTabela;
        mudaDia = entrada.compareTo(saida) > 0;
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

    public boolean mudaDia() {
        return mudaDia;
    }
}

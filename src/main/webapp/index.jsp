<%@ page import="br.com.insight.pontodigital.bean.PontoBean" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.insight.pontodigital.dao.PontoDAO" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html data-bs-theme="dark">
<head>
    <title>Ponto Digital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <style>
        div {
            padding: 8px;
        }

        label {
            display: block;
        }

        input {
            display: block;
        }

        form {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        body {
            margin: 50px 20px 50px 20px;
            font-family: arial, sans-serif;
        }

        table {
            table-layout: auto;
            margin: 30px auto;
            border-collapse: collapse;
            width: 30%;
            padding: 10px;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: center;
            padding: 8px;
        }

        .form-table, .campos {
            display: flex;
            flex-direction: row;
            justify-content: space-evenly;
        }
    </style>
</head>
<body>
<%
    List<PontoBean> horarios = PontoDAO.listHorarios;
    List<PontoBean> marcacoes = PontoDAO.listMarcacoes;
    List<PontoBean> atrasos = new ArrayList<>();
    List<PontoBean> horasExtras = new ArrayList<>();
    int size = 0;
    int indexHorario = 1;
    int indexMarcacao = 1;
    if (horarios != null) {
        size = horarios.size();
        horarios.sort(Comparator.comparing(PontoBean::getEntrada));
    }
    if (marcacoes != null) {
        marcacoes.sort(Comparator.comparing(PontoBean::getEntrada));
    }

    if (horarios != null && marcacoes != null) {
        for (PontoBean horario : horarios) {
            int indexAtualH = horarios.indexOf(horario);
            int nIndicesH = horarios.size();
            for (PontoBean marcacao : marcacoes) {
                int indexAtualM = marcacoes.indexOf(marcacao);
                int nIndicesM = marcacoes.size();
                PontoBean marcacaoAnterior;
                PontoBean proximaMarcacao;
                PontoBean horarioAnterior;
                PontoBean proximoHorario;
                if (nIndicesH < 2) {
                    if (nIndicesM == indexAtualM + 1) {
                        if (!horario.mudaDia() && !marcacao.mudaDia()) {
                            if (marcacao.getEntrada().compareTo(horario.getSaida()) >= 0) {
                                horasExtras.add(new PontoBean(marcacao.getEntrada(), marcacao.getSaida(), 4L));
                            } else if (marcacao.getSaida().compareTo(horario.getSaida()) > 0 && marcacao.getEntrada().compareTo(horario.getEntrada()) >= 0) {
                                horasExtras.add(new PontoBean(horario.getSaida(), marcacao.getSaida(), 4L));
                            }
                            if (nIndicesM > 1) {
                                marcacaoAnterior = marcacoes.get(indexAtualM - 1);
                                if (!marcacaoAnterior.mudaDia()) {
                                    if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacao.getSaida().compareTo(horario.getSaida()) > 0 && marcacao.getEntrada().compareTo(horario.getSaida()) < 0 && marcacaoAnterior.getSaida().compareTo(horario.getEntrada()) <= 0) {
                                        atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                                    }
                                    if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacaoAnterior.getSaida().compareTo(horario.getEntrada()) <= 0) {
                                        atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                                    }
                                }
                            }
                            if (marcacao.getSaida().compareTo(horario.getSaida()) < 0) {
                                atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 3L));
                            }
                        }
                    }
                    if (nIndicesM > indexAtualM + 1 && indexAtualM > 0) {
                        proximaMarcacao = marcacoes.get(indexAtualM + 1);
                        marcacaoAnterior = marcacoes.get(indexAtualM - 1);
                        if (!marcacao.mudaDia() && !horario.mudaDia() && !proximaMarcacao.mudaDia() && !marcacaoAnterior.mudaDia()) {
                            if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacao.getSaida().compareTo(horario.getSaida()) < 0 && proximaMarcacao.getEntrada().compareTo(horario.getSaida()) > 0) {
                                atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                                atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 3L));
                            }
                            if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacaoAnterior.getSaida().compareTo(horario.getEntrada()) <= 0) {
                                atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                            }
                            if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacao.getSaida().compareTo(horario.getSaida()) < 0 && proximaMarcacao.getEntrada().compareTo(horario.getSaida()) <= 0) {
                                atrasos.add(new PontoBean(marcacao.getSaida(), proximaMarcacao.getEntrada(), 3L));
                            }
                        }
                    }
                }
                if (nIndicesM < 2) {
                    if (!horario.mudaDia() && !marcacao.mudaDia()) {
                        if (horario.getSaida().compareTo(marcacao.getEntrada()) <= 0) {
                            atrasos.add(new PontoBean(horario.getEntrada(), horario.getSaida(), 3L));
                            horasExtras.add(new PontoBean(marcacao.getEntrada(), marcacao.getSaida(), 4L));
                        }
                        if (horario.getEntrada().compareTo(marcacao.getSaida()) >= 0) {
                            if (nIndicesH > 1) {
                                atrasos.add(new PontoBean(horario.getEntrada(), horario.getSaida(), 3L));
                            }
                            if (indexAtualH > 0) {
                                horarioAnterior = horarios.get(indexAtualH - 1);
                                if (!horarioAnterior.mudaDia() && horarioAnterior.getSaida().compareTo(marcacao.getSaida()) < 0 && horarioAnterior.getEntrada().compareTo(marcacao.getEntrada()) > 0) {
                                    horasExtras.add(new PontoBean(marcacao.getEntrada(), marcacao.getSaida(), 4L));
                                }
                            }
                        }
                    }
                }
                if (indexAtualH < 1 && indexAtualM < 1) {
                    if (!horario.mudaDia() && !marcacao.mudaDia()) {
                        if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacao.getSaida().equals(horario.getSaida())) {
                            atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                        }
                        if (marcacao.getSaida().compareTo(horario.getSaida()) < 0 && marcacao.getEntrada().equals(horario.getEntrada())) {
                            atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 3L));
                        }
                        if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacao.getSaida().compareTo(horario.getSaida()) < 0) {
                            atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                            atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 3L));
                        }
                        if (marcacao.getEntrada().compareTo(horario.getEntrada()) < 0 && marcacao.getSaida().compareTo(horario.getEntrada()) > 0) {
                            horasExtras.add(new PontoBean(marcacao.getEntrada(), horario.getEntrada(), 4L));
                        }
                        if (marcacao.getEntrada().compareTo(horario.getEntrada()) < 0 && marcacao.getSaida().compareTo(horario.getEntrada()) <= 0) {
                            horasExtras.add(new PontoBean(marcacao.getEntrada(), marcacao.getSaida(), 4L));
                        }
                    }
                }
                if (nIndicesH > 1 && nIndicesM > 1) {
                    if (!marcacao.mudaDia() && !horario.mudaDia()) {
                        if (indexAtualM < 1 && indexAtualH < 1) {
                            proximaMarcacao = marcacoes.get(indexAtualM + 1);
                            proximoHorario = horarios.get(indexAtualH + 1);
                            if (!proximaMarcacao.mudaDia() && !proximoHorario.mudaDia()) {
                                if (marcacao.getSaida().compareTo(proximoHorario.getEntrada()) < 0 && proximaMarcacao.getEntrada().compareTo(proximoHorario.getSaida()) > 0 && proximoHorario.getEntrada().compareTo(proximoHorario.getSaida()) < 0) {
                                    atrasos.add(new PontoBean(proximoHorario.getEntrada(), proximoHorario.getSaida(), 3L));
                                }
                                if (marcacao.getSaida().compareTo(horario.getEntrada()) <= 0 && horario.getSaida().compareTo(proximaMarcacao.getEntrada()) <= 0 && horario.getEntrada().compareTo(horario.getSaida()) < 0) {
                                    atrasos.add(new PontoBean(horario.getEntrada(), horario.getSaida(), 3L));
                                }
                                if (marcacao.getEntrada().equals(horario.getEntrada()) && marcacao.getSaida().compareTo(horario.getSaida()) < 0 && proximaMarcacao.getEntrada().compareTo(horario.getSaida()) >= 0) {
                                    atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 3L));
                                }
                            }
                        }
                        if (indexAtualH + 1 == nIndicesH && indexAtualM + 1 == nIndicesM && nIndicesM == nIndicesH) {
                            if (marcacao.getSaida().compareTo(horario.getEntrada()) <= 0) {
                                atrasos.add(new PontoBean(horario.getEntrada(), horario.getSaida(), 3L));
                                horasExtras.add(new PontoBean(marcacao.getEntrada(), marcacao.getSaida(), 4L));
                            }
                            if (marcacao.getEntrada().compareTo(horario.getSaida()) > 0 && marcacao.getSaida().compareTo(horario.getSaida()) < 0) {
                                atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 3L));
                            }
                            if (marcacao.getEntrada().compareTo(horario.getSaida()) >= 0) {
                                horasExtras.add(new PontoBean(marcacao.getEntrada(), marcacao.getSaida(), 4L));
                            }
                            if (marcacao.getEntrada().compareTo(horario.getEntrada()) < 0 && marcacao.getSaida().compareTo(horario.getSaida()) < 0) {
                                horasExtras.add(new PontoBean(marcacao.getEntrada(), horario.getEntrada(), 3L));
                                atrasos.add(new PontoBean(marcacao.getSaida(), horario.getSaida(), 4L));
                            }
                            if (marcacao.getEntrada().compareTo(horario.getEntrada()) > 0 && marcacao.getSaida().compareTo(horario.getSaida()) > 0) {
                                atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                                horasExtras.add(new PontoBean(horario.getSaida(), marcacao.getSaida(), 4L));
                            }
                        }
                        if (nIndicesM < nIndicesH && indexAtualH + 1 == nIndicesH && indexAtualM + 1 == nIndicesM) {
                            if (horario.getEntrada().compareTo(marcacao.getSaida()) > 0) {
                                atrasos.add(new PontoBean(horario.getEntrada(), horario.getSaida(), 3L));
                            }
                        }
                        if (indexAtualH + 1 < nIndicesH && indexAtualH > 0 && indexAtualM + 1 == nIndicesM) {
                            proximoHorario = horarios.get(indexAtualH + 1);
                            if (horario.getEntrada().compareTo(marcacao.getEntrada()) < 0 && horario.getSaida().compareTo(marcacao.getSaida()) < 0 && proximoHorario.getEntrada().compareTo(marcacao.getSaida()) >= 0) {
                                atrasos.add(new PontoBean(horario.getEntrada(), marcacao.getEntrada(), 3L));
                                horasExtras.add(new PontoBean(horario.getSaida(), marcacao.getSaida(), 4L));
                            }
                        }
                    }
                }
                if (nIndicesM < 2 && nIndicesH < 2) {
                    if (horario.mudaDia() && marcacao.mudaDia()) {
                        if (marcacao.getEntrada().compareTo(horario.getEntrada()) < 0 && marcacao.getSaida().equals(horario.getSaida())) {
                            horasExtras.add(new PontoBean(marcacao.getEntrada(), horario.getEntrada(), 4L));
                        }
                    }
                }
            }
        }
    }

    atrasos.sort(Comparator.comparing(PontoBean::getEntrada));
    horasExtras.sort(Comparator.comparing(PontoBean::getEntrada));
%>


<div class="form-table">
    <div class="table-responsive">
        <h4 class="text-center mt-4">Horários de Trabalho</h4>
        <form method="post" action="horarios">
            <div class="campos">
                <div class="mb-3">
                    <label class="form-label" for="entradaHorarios">Entrada</label>
                    <input class="form-control" type="time" name="entradaHorarios" id="entradaHorarios">
                </div>
                <div class="mb-3">
                    <label class="form-label" for="saidaHorarios">Saída</label>
                    <input class="form-control" type="time" name="saidaHorarios" id="saidaHorarios">
                </div>
            </div>
            <input id="inserirTabelaHorarios" type="submit" class="btn btn-success" value="Inserir Ponto"
                   onclick="validaTabela('tabela-horarios')" <%if (size > 2) {%> disabled <%} else {%><%}%>/>
        </form>

        <table class="table table-hover align-middle" id="tabela-horarios">
            <thead>
            <tr>
                <th>Entrada</th>
                <th>Saída</th>
                <th>Editar</th>
                <th>Excluir</th>
            </tr>
            <thead>
                <%
                if (horarios != null) {
                    for (PontoBean horario : horarios) {
            %>
            <tbody>
            <tr id="linha-horario-<%=indexHorario%>">
                <td><%= horario.getEntrada()%>
                </td>
                <td><%= horario.getSaida()%>
                </td>
                <td><input type="button" class="btn btn-outline-warning btn-sm" value="Editar" id="editar-horario"
                           onclick="editar(<%= indexHorario %>, 1)"/></td>
                <td><input type="button" class="btn btn-outline-danger btn-sm" value="Excluir" id="excluir-horario"
                           onclick="remover(<%=indexHorario%>, 1)"/>
                </td>
            </tr>
            </tbody>
            <% indexHorario++;
            }
            }
            %>
        </table>
    </div>

    <div class="table-responsive">
        <h4 class="text-center mt-4">Marcações Feitas</h4>
        <form method="post" action="marcacoes">
            <div class="campos">
                <div class="mb-3">
                    <label class="form-label" for="entradaMarcacoes">Entrada</label>
                    <input class="form-control" type="time" name="entradaMarcacoes" id="entradaMarcacoes">
                </div>
                <div class="mb-3">
                    <label class="form-label" for="saidaMarcacoes">Saída</label>
                    <input class="form-control" type="time" name="saidaMarcacoes" id="saidaMarcacoes">
                </div>
            </div>
            <input id="inserirTabelaMarcacoes" class="btn btn-success" type="submit" value="Inserir Ponto"
                   onclick="validaTabela('tabela-marcacoes')"/>
        </form>

        <table class="table table-hover align-middle" id="tabela-marcacoes">
            <thead>
            <tr>
                <th>Entrada</th>
                <th>Saída</th>
                <th>Editar</th>
                <th>Excluir</th>
            </tr>
            </thead>
            <%
                if (marcacoes != null) {
                    for (PontoBean marcacao : marcacoes) {
            %>
            <tbody>
            <tr id="linha-marcacao-<%=indexMarcacao%>">
                <td><%= marcacao.getEntrada()%>
                </td>
                <td><%= marcacao.getSaida()%>
                </td>
                <td><input type="button" class="btn btn-outline-warning btn-sm" value="Editar"
                           onclick="editar(<%=indexMarcacao%>, 2)"/></td>
                <td><input type="button" class="btn btn-outline-danger btn-sm" value="Excluir"
                           onclick="remover(<%=indexMarcacao%>, 2)"/></td>
            </tr>
            </tbody>
            <%
                        indexMarcacao++;
                    }
                }
            %>
        </table>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle" id="tabela-atrasos">
            <h4 class="text-center mt-4">Atrasos</h4>
            <thead>
            <tr>
                <th>Entrada</th>
                <th>Saída</th>
            </tr>
            <thead>
                <%
                for (PontoBean atraso : atrasos) {
            %>
            <tbody>
            <tr>
                <td><%=atraso.getEntrada()%>
                </td>
                <td><%=atraso.getSaida()%>
                </td>
            </tr>
            </tbody>
            <%
                }
            %>
        </table>
    </div>
    <div class="table-responsive">
        <table class="table table-hover align-middle" id="tabela-hora-extra">
            <h4 class="text-center mt-4">Horas Extras</h4>
            <thead>
            <tr>
                <th>Entrada</th>
                <th>Saída</th>
            </tr>
            <thead>
                <%
                for (PontoBean he : horasExtras) {
            %>
            <tbody>
            <tr id="linha-horario-<%=indexHorario%>">
                <td><%=he.getEntrada()%>
                </td>
                <td><%=he.getSaida()%>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>


<script>
    function validaTabela(idTabela) {
        var entradaValue;
        var saidaValue;
        var tableRows;

        if (idTabela === "tabela-horarios") {
            entradaValue = document.getElementById("entradaHorarios").value;
            saidaValue = document.getElementById("saidaHorarios").value;
            tableRows = document.querySelectorAll("#tabela-horarios tr");
        } else {
            entradaValue = document.getElementById("entradaMarcacoes").value;
            saidaValue = document.getElementById("saidaMarcacoes").value;
            tableRows = document.querySelectorAll("#tabela-marcacoes tr");
        }

        if (entradaValue.length < 5 || saidaValue.length < 5) {
            alert("Insira horários de entrada e saída válidos!!");
            return;
        }

        if (saidaValue <= entradaValue && saidaValue >= '12:00') {
            alert("Horário de saída não pode ser posterior ao horário de entrada!");
            return;
        }

        for (var i = 1; i < tableRows.length; i++) {
            var existingEntrada = tableRows[i].querySelector("td:first-child").textContent; //entrada da linha atual
            var existingSaida = tableRows[i].querySelector("td:nth-child(2)").textContent; //saída da linha atual

            if (existingEntrada > existingSaida) {
                if (entradaValue > existingEntrada || entradaValue > saidaValue) {
                    alert("Este período já foi registrado!");
                    return;
                }
            } else if ((entradaValue >= existingEntrada && entradaValue <= existingSaida) || //verificando entrada
                (saidaValue >= existingEntrada && saidaValue <= existingSaida) || //verificando saída
                (entradaValue <= existingEntrada && saidaValue >= existingSaida)) { //verificando entrada e saída
                alert("Este período já foi registrado!");
                return;
            }
        }
    }

    function editar(index, tipoTabela) {
        var linha;

        if (tipoTabela === 1) {
            linha = document.getElementById("linha-horario-" + index);
        } else {
            linha = document.getElementById("linha-marcacao-" + index);
        }
        var oldEntrada = linha.querySelector("td:nth-child(1)");
        var oldEntradaTime = oldEntrada.textContent;
        var oldSaida = linha.querySelector("td:nth-child(2)");
        var oldSaidaTime = oldSaida.textContent;
        var btnEditar = linha.querySelector("td:nth-child(3) input");

        var newInputEntrada = document.createElement("input");
        newInputEntrada.type = "time";
        newInputEntrada.className = "form-control";
        newInputEntrada.value = oldEntradaTime.trim();

        var newInputSaida = document.createElement("input");
        newInputSaida.type = "time";
        newInputSaida.className = "form-control";
        newInputSaida.value = oldSaidaTime.trim();

        oldEntrada.textContent = "";
        oldEntrada.appendChild(newInputEntrada);
        oldSaida.textContent = "";
        oldSaida.appendChild(newInputSaida);

        var btnSalvar = document.createElement("input");
        btnSalvar.type = "button";
        btnSalvar.value = "Salvar";
        btnSalvar.className = "btn btn-sm btn-success";
        btnSalvar.id = "btn-salvar";
        btnEditar.replaceWith(btnSalvar);

        btnSalvar.addEventListener("click", function () {
                var newEntrada = newInputEntrada.value;
                var newSaida = newInputSaida.value;

                if (newEntrada >= newSaida && newSaida >= '12:00') {
                    alert("Horário de saída não pode ser posterior ao horário de entrada!");
                    oldEntrada.removeChild(newInputEntrada);
                    oldSaida.removeChild(newInputSaida);
                    btnSalvar.replaceWith(btnEditar);
                    location.reload();
                    return;
                }

                var tableRows;

                if (tipoTabela === 1) {
                    tableRows = document.querySelectorAll("#tabela-horarios tr");
                } else {
                    tableRows = document.querySelectorAll("#tabela-marcacoes tr");
                }

                for (var i = 1; i < tableRows.length; i++) {
                    if (i !== index) {
                        console.log("i:", i);
                        console.log("index:", index);
                        var existingEntrada = tableRows[i].querySelector("td:first-child").textContent; //entrada da linha atual
                        var existingSaida = tableRows[i].querySelector("td:nth-child(2)").textContent; //saída da linha atual

                        if (existingEntrada > existingSaida) {
                            if (newEntrada > existingEntrada || newEntrada > newSaida) {
                                alert("Este período já foi registrado!");
                                oldEntrada.removeChild(newInputEntrada);
                                oldSaida.removeChild(newInputSaida);
                                btnSalvar.replaceWith(btnEditar);
                                location.reload();
                                return;
                            }
                        } else if ((newEntrada >= existingEntrada && newEntrada <= existingSaida) || //verificando entrada
                            (newSaida >= existingEntrada && newSaida <= existingSaida) || //verificando saída
                            (newEntrada <= existingEntrada && newSaida >= existingSaida)) { //verificando entrada e saída
                            alert("Este período já foi registrado!");
                            oldEntrada.removeChild(newInputEntrada);
                            oldSaida.removeChild(newInputSaida);
                            btnSalvar.replaceWith(btnEditar);
                            location.reload();
                            return;
                        }
                    }
                }

                var data = {
                    entrada: newEntrada,
                    saida: newSaida
                };

                if (tipoTabela === 1) {
                    fetch("horarios?index=" + index, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify(data)
                    }).then(response => {
                        location.reload();
                    }).catch(error => {
                        oldEntrada.removeChild(newInputEntrada);
                        oldSaida.removeChild(newInputSaida);
                        btnSalvar.replaceWith(btnEditar);
                        console.error("Erro ao atualizar registro:", error);
                    });
                } else {
                    fetch("marcacoes?index=" + index, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify(data)
                    }).then(response => {
                        location.reload();
                    }).catch(error => {
                        oldEntrada.removeChild(newInputEntrada);
                        oldSaida.removeChild(newInputSaida);
                        btnSalvar.replaceWith(btnEditar);
                        console.error("Erro ao atualizar registro:", error);
                    });
                }


                oldEntrada.removeChild(newInputEntrada);
                oldSaida.removeChild(newInputSaida);
                btnSalvar.replaceWith(btnEditar);
            }
        )
    }

    function remover(index, tipoTabela) {
        if (confirm("Tem certeza que deseja excluir esse ponto?")) {
            if (tipoTabela === 1) {
                fetch("horarios", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(index),
                }).then(response => {
                    location.reload();
                }).catch(error => {
                    console.error("Erro ao excluir linha:", error);
                });
                return;
            }

            fetch("marcacoes", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(index),
            }).then(response => {
                location.reload();
            }).catch(error => {
                console.error("Erro ao excluir linha:", error);
            });
        }
    }
</script>

</body>
</html>
<%@ page import="br.com.insight.pontodigital.bean.PontoBean" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.insight.pontodigital.dao.PontoDAO" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
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
    int size = 0;
    int indexHorario = 0;
    int indexMarcacao = 0;
    if (horarios != null) {
        size = horarios.size();
        horarios.sort(Comparator.comparing(PontoBean::getEntrada));
    }
    if (marcacoes != null) {
        marcacoes.sort(Comparator.comparing(PontoBean::getEntrada));
    }
%>


<div class="form-table">
    <div class="table-responsive">
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
            <h4 class="text-center mt-4">Horários de Trabalho</h4>
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
                <td><input type="button" class="btn btn-outline-warning btn-sm" value="Editar"
                           onclick="editarHorario(<%= indexHorario %>)"/></td>
                <td><input type="button" class="btn btn-outline-danger btn-sm" value="Excluir"/></td>
            </tr>
            </tbody>
            <%
                        indexHorario++;
                    }
                }
            %>
        </table>
    </div>

    <div class="table-responsive">
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
            <h4 class="text-center mt-4">Marcações Feitas</h4>
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
            <tr>
                <td><%= marcacao.getEntrada()%>
                </td>
                <td><%= marcacao.getSaida()%>
                </td>
                <td><input type="button" class="btn btn-outline-warning btn-sm" value="Editar"/></td>
                <td><input type="button" class="btn btn-outline-danger btn-sm" value="Excluir"/></td>
            </tr>
            </tbody>
            <%
                    }
                }
            %>
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

        if (saidaValue <= entradaValue) {
            alert("Horário de saída não pode ser posterior ao horário de entrada!");
            return;
        }

        for (var i = 1; i <= tableRows.length; i++) {
            var existingEntrada = tableRows[i].querySelector("td:first-child").textContent; //entrada da linha atual
            var existingSaida = tableRows[i].querySelector("td:nth-child(2)").textContent; //saída da linha atual

            if ((entradaValue >= existingEntrada && entradaValue <= existingSaida) || //verificando entrada
                (saidaValue >= existingEntrada && saidaValue <= existingSaida) || //verificando saída
                (entradaValue <= existingEntrada && saidaValue >= existingSaida)) { //verificando entrada e saída
                alert("Este período já foi registrado!");
                return;
            }
        }
    }

    function editarHorario(index) {
        var linha = document.getElementById("linha-horario-" + index);
        var oldEntrada = linha.querySelector("td:nth-child(1)");
        var oldSaida = linha.querySelector("td:nth-child(2)");

        var newEntrada = prompt("Digite o novo horário de entrada:", oldEntrada.textContent);
        var newSaida = prompt("Digite o novo horário de saída:", oldSaida.textContent);

        if (newEntrada >= newSaida) {
            alert("Horário de saída não pode ser posterior ao horário de entrada!");
            return;
        }

        var tableRows = document.querySelectorAll("#tabela-horarios tr");

        for (var i = 1; i <= tableRows.length; i++) {
            var existingEntrada = tableRows[i].querySelector("td:first-child").textContent; //entrada da linha atual
            var existingSaida = tableRows[i].querySelector("td:nth-child(2)").textContent; //saída da linha atual

            if (i !== index && (newEntrada >= existingEntrada && newEntrada <= existingSaida) || //verificando entrada
                (newSaida >= existingEntrada && newSaida <= existingSaida) || //verificando saída
                (newEntrada <= existingEntrada && newSaida >= existingSaida)) { //verificando entrada e saída
                alert("Este período já foi registrado!");
                return;
            }
        }

        <%
//            if(horarios != null){
//                horarios.get(indexHorario);
//            }
        %>
        oldEntrada.textContent = newEntrada;
        oldSaida.textContent = newSaida;
    }
</script>

</body>
</html>
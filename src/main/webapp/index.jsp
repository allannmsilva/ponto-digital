<%@ page import="br.com.insight.pontodigital.model.Ponto" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ponto Digital</title>
    <style>
        div{
            text-align: left;
            padding: 10px;
        }

        form{
            display: flex;
            justify-content: center;
        }

        body{
            margin: 80px 50px 80px 50px;
            font-family: arial, sans-serif;
        }

        table {
            table-layout: fixed;
            margin: 30px auto;
            border-collapse: collapse;
            width: 30%;
            padding: 10px;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: center;
            width: 120px;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }

        .buttons{
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>

<form>
    <div>
        <label for="entrada">Entrada: </label><br>
        <input type="time" id="entrada">
    </div>
    <div>
        <label for="saida">Saída: </label><br>
        <input type="time" id="saida">
    </div>
</form>

<div class="buttons">
    <input id="inserirTabelaHorarios" type="submit" value="Inserir Ponto" onclick="inserirHorarioTrabalho('tabela-horarios')"/>
</div>

<%!
    Ponto p = new Ponto();
%>


<table id="tabela-horarios">
    <caption>Horário de Trabalho</caption>
    <tr>
        <th>Entrada</th>
        <th>Saída</th>
    </tr>
</table>

<form>
    <div>
        <label for="entrada">Entrada: </label><br>
        <input type="time" id="entrada2">
    </div>
    <div>
        <label for="saida">Saída: </label><br>
        <input type="time" id="saida2">
    </div>
</form>

<div class="buttons">
    <input id="inserirTabelaMarcacoes" type="submit" value="Inserir Ponto" onclick="inserirHorarioTrabalho('tabela-marcacoes')"/>
</div>

<table id="tabela-marcacoes">
    <caption>Marcações</caption>
    <tr>
        <th>Entrada</th>
        <th>Saída</th>
    </tr>
</table>

<script>
    function inserirHorarioTrabalho(idTabela){
        var newLine = document.createElement("tr");
        var col1 = document.createElement("td");
        var col2 = document.createElement("td");
        var entradaValue;
        var saidaValue;
        var tableRows;

        if(idTabela === "tabela-horarios"){
            entradaValue = document.getElementById("entrada").value;
            col1.textContent = entradaValue;

            saidaValue = document.getElementById("saida").value;
            col2.textContent = saidaValue;

            tableRows = document.querySelectorAll("#tabela-horarios tr");
        } else {
            entradaValue = document.getElementById("entrada2").value;
            col1.textContent = entradaValue;

            saidaValue = document.getElementById("saida2").value;
            col2.textContent = saidaValue;

            tableRows = document.querySelectorAll("#tabela-marcacoes tr");
        }

        if(entradaValue.length < 5 || saidaValue.length < 5){
            alert("É obrigatório inserir um horário de entrada e de saída!");
            return;
        }

        if(saidaValue <= entradaValue){
            alert("Horário de saída não pode ser posterior ao horário de entrada!");
            return;
        }

        newLine.appendChild(col1);
        newLine.appendChild(col2);

        var tabela = document.getElementById(idTabela);

        for (var i = 1; i < tableRows.length; i++) {
            var existingEntrada = tableRows[i].querySelector("td:first-child").textContent; //entrada da linha atual
            var existingSaida = tableRows[i].querySelector("td:last-child").textContent; //saída da linha atual

            if ((entradaValue >= existingEntrada && entradaValue <= existingSaida) || //verificando entrada
                (saidaValue >= existingEntrada && saidaValue <= existingSaida) || //verificando saída
                (entradaValue <= existingEntrada && saidaValue >= existingSaida)) { //verificando entrada e saída
                alert("Este período já foi registrado!");
                return;
            }

            if (entradaValue < existingEntrada) { //inserindo de forma ordenada
                tabela.insertBefore(newLine, tableRows[i]);
                checkTableLenght(tabela);
                return;
            }
        }

        tabela.appendChild(newLine);
        checkTableLenght(tabela);
    }

    function checkTableLenght(tabela){
        //verifica se é a tabela de pontos e limita a quantidade de registros se for
        if(tabela.rows.length > 3 && tabela.id === "tabela-horarios"){
            document.getElementById("inserirTabelaHorarios").setAttribute("disabled", "true");
        }
    }
</script>

</body>
</html>
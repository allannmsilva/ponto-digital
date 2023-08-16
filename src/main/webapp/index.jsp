<%@ page import="main.java.br.com.insight.pontodigital.model.Periodo" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <input id="inserir" type="submit" value="Inserir Ponto" onclick="inserirHorarioTrabalho()"/>
</div>

<%!
    Periodo p = new Periodo();
%>


<table id="tabela-pontos">
    <caption>Horário de Trabalho</caption>
    <tr>
        <th>Entrada</th>
        <th>Saída</th>
    </tr>
</table>

<script>
    function inserirHorarioTrabalho(){
        var newLine = document.createElement("tr");

        var col1 = document.createElement("td");
        var entradaValue = document.getElementById("entrada").value;
        col1.textContent = entradaValue;

        var col2 = document.createElement("td");
        var saidaValue = document.getElementById("saida").value;
        col2.textContent = saidaValue;

        if(col1.textContent.length < 5 || col2.textContent.length < 5){
            alert("É obrigatório inserir um horário de entrada e de saída!");
            return;
        }

        if(saidaValue <= entradaValue){
            alert("Saída deve ocorrer após entrada!");
            return;
        }

        newLine.appendChild(col1);
        newLine.appendChild(col2);

        var tabela = document.getElementById("tabela-pontos");

        var tableRows = document.querySelectorAll("#tabela-pontos tr");
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
                checkTableLenght(tableRows.length);
                return;
            }
        }

        tabela.appendChild(newLine);
        checkTableLenght(tableRows.length);
    }

    function checkTableLenght(lenght){
        if(lenght > 2){
            document.getElementById("inserir").setAttribute("disabled", "true");
        }
    }
</script>

</body>
</html>
<%@ page import="main.java.br.com.insight.pontodigital.model.Periodo" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ponto Digital</title>
    <style>
        table {
            margin: 0 auto;
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 80%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
</head>
<body>

<%!
    Periodo p = new Periodo();
%>

<%
    p.setEntrada(new Date());
    p.setSaida(new Date());
%>

<h1><%= p.getEntrada() %>
</h1>
<br/>
<a href="hello-servlet">Clica aqui!</a>
<br>
<a href="testando">Teste</a>


<table>
    <tr>
        <th>Entrada</th>
        <th>Saída</th>
    </tr>
    <tr>
        <td><%= new SimpleDateFormat("HH:mm").format(p.getEntrada()) %></td>
        <td><%= new SimpleDateFormat("HH:mm").format(p.getSaida()) %></td>
    </tr>
    <tr>
        <td>Centro comercial Moctezuma</td>
        <td>Francisco Chang</td>
    </tr>
    <tr>
        <td>Ernst Handel</td>
        <td>Roland Mendel</td>
    </tr>
    <tr>
        <td>Island Trading</td>
        <td>Helen Bennett</td>
    </tr>
    <tr>
        <td>Laughing Bacchus Winecellars</td>
        <td>Yoshi Tannamuri</td>
    </tr>
    <tr>
        <td>Magazzini Alimentari Riuniti</td>
        <td>Giovanni Rovelli</td>
    </tr>
</table>

</body>
</html>
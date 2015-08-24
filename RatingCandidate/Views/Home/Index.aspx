<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Formulário de Avaliação
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function validateValue(idCampo) {
            var element = document.getElementById(idCampo);

            if (element.value > 10 || element.value < 0) {
                element.style.border = "1px solid red";
                element.title = "Somente de 0 a 10";
                element.value = "";
            } else {
                element.style.border = "1px solid #cccccc";
                element.title = "";
            }
        }

        var current_path = window.location.pathname.split('/').pop();

        function ClearFields() {
            $("input[type=text]").val("");
            $("input[type=number]").val("")
        };

        function validateFields() {

            if ($("#nameCandidate").val() == "" && $("#emailCandidate").val() == "") {
                $("#nameCandidate").css("border", "1px solid red");
                $("#nameCandidate").attr("title", "Campo obrigatório");
                $("#emailCandidate").css("border", "1px solid red");
                $("#emailCandidate").attr("title", "Campo obrigatório");
                return false;
            }

            if ($("#nameCandidate").val() == "") {
                $("#nameCandidate").css("border", "1px solid red");
                $("#nameCandidate").attr("title", "Campo obrigatório");
                return false;
            } else {
                $("#nameCandidate").css("border", "1px solid #cccccc");
                $("#nameCandidate").attr("title", "");
            }

            if ($("#emailCandidate").val() == "") {
                $("#emailCandidate").css("border", "1px solid red");
                $("#emailCandidate").attr("title", "Campo obrigatório");
                return false;
            } else {
                var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
                if (!testEmail.test($("#emailCandidate").val())) {
                    $("#emailCandidate").css("border", "1px solid red");
                    $("#emailCandidate").attr("title", "Email Inválido");
                    return false;
                } else {
                    $("#emailCandidate").css("border", "1px solid #cccccc");
                    $("#emailCandidate").attr("title", "");
                }
            }

            return true;
        }

        function SendEmail() {
            arrayFrontEnd = [$("#html").val(), $("#css").val(), $("#javascript").val()];
            arrayBackEnd = [$("#python").val(), $("#django").val()];
            arrayMobile = [$("#iOS").val(), $("#android").val()];

            var invalid = validateFields();
            if (!invalid)
                return false;

            $.ajax({
                url: 'Home/SendEmail',
                type: 'POST',
                traditional: true,
                data: {
                    name: $("#nameCandidate").val(),
                    email: $("#emailCandidate").val(),
                    arrayFrontEnd: arrayFrontEnd,
                    arrayBackEnd: arrayBackEnd,
                    arrayMobile: arrayMobile
                },
                success: function (result) {
                    if (result == "True") {
                        alert("Verifique a caixa de entrada do seu email! (:");
                        ClearFields();
                        $("#MainContent_upArrow").trigger("click");
                    } else
                        alert("Ocorreu um erro e não foi possível enviar o email");
                }
            });
        };

    </script>
    <style type="text/css">
        input
        {
            border: 1px solid #cccccc;
            outline: 0;
            height: 35px;
            width: 520px;
            border-radius: 1px 4px 4px 1px;
            box-sizing: border-box;
            font-size: 27px;
            margin-bottom: 20px;
        }

            input[type=number]
            {
                height: 35px;
                width: 100px;
            }

        label
        {
            display: inline-block;
            vertical-align: middle;
            border: 1px solid #cccccc;
            border-left: 1px solid #cccccc;
            font-size: 16px;
            background-color: #f0f0f0;
            line-height: 30px;
            padding: 0 6px;
            height: 32px;
            border-radius: 7px 2px 2px 7px;
            box-sizing: border-box;
        }
    </style>

    <div id="middleBar" style="text-align: center; background-color: #E8EDFF">
        <span>Bem Vindo a<br />
            <br />
        </span>
        <asp:Image ImageUrl="~/Images/meusPedidosLogo.png" runat="server" /><br />
        <img id="downArrow" src="~/Images/downArrow.png" runat="server" width="20" height="20" />
    </div>

    <div id="topBar" style="border: 2px solid rgb(210, 223, 255); height: 25%; background-color: #E8EDFF; text-align: center; visibility: hidden;">
        <span>Formulário de Avaliação
            <br />
            de Candidatos
        </span>
        <br />
        <%--        <span style="font:8px;">Dados do candidato (Campos obrigatórios)</span>--%>
        <br />
        <label for="textbox">Nome</label>
        <input type="text" id="nameCandidate" />
        <br />
        <label for="textbox">Email</label>
        <input type="text" id="emailCandidate" />
        <br />
        <label>Avalie seu conhecimento de 0 a 10 nos seguintes itens:</label>
        <br />
        <label>
            Html:       
        </label>
        <input type="number" min="0" max="10" id="html" onchange="validateValue('html')" />
        <br />
        <label>
            CSS:       
        </label>
        <input type="number" min="0" max="10" id="css" onchange="validateValue('css')" />
        <br />
        <label>
            Javascript:       
        </label>
        <input type="number" min="0" max="10" id="javascript" onchange="validateValue('javascript')">
        <br />
        <label>
            Python:       
        </label>
        <input type="number" min="0" max="10" id="python" onchange="validateValue('python')" />
        <br />
        <label>
            Django:       
        </label>
        <input type="number" min="0" max="10" id="django" onchange="validateValue('django')" />
        <br />
        <label>
            Desenvolvimento iOS:       
        </label>
        <input type="number" min="0" max="10" id="iOS" onchange="validateValue('iOS')" />
        <br />
        <label>
            Desenvolvimento Android:       
        </label>
        <input type="number" min="0" max="10" id="android" onchange="validateValue('android')" />

        <form id="frm" runat="server">
            <input type="button" style="width: 100px; height: 30px;" value="Enviar" runat="server" onclick="return SendEmail()" />

            <input type="button" style="width: 100px; height: 30px;" value="Limpar" runat="server" id="btnLimpar" onclick="ClearFields()" />

        </form>

        <br />
        <img id="upArrow" src="~/Images/upArrow.png" runat="server" width="20" height="20" />
    </div>
    <script>

        $(document).ready(function () {
            $("#MainContent_upArrow").on("click", function () {
                $("#topBar").slideUp("slow", function () {
                    $("#middleBar").css("display", "block");
                    $("#middleBar").show("2000");
                });
            });

            $("#MainContent_downArrow").on("click", function () {
                $("#middleBar").slideUp("slow", function () {
                    $("#topBar").css("visibility", "visible");
                    $("#topBar").show("2000");
                });
            });
        });

    </script>

</asp:Content>

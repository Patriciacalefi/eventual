function verificaNumero(e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            }

function Imprimir(){
  window.print();
}
function MM_openBrWindow(theURL,winName,features) {
window.open(theURL,winName,features);
}

function PrintDiv(div)
{
	$('#'+div).printElement();
}

function FormataCpf(campo, teclapres)
	{
		var tecla = teclapres.keyCode;
		var vr = new String(campo.value);
		vr = vr.replace(".", "");
		vr = vr.replace("/", "");
		vr = vr.replace("-", "");
		tam = vr.length + 1;
		if (tecla != 14)
		{
			if (tam == 4)
				campo.value = vr.substr(0, 3) + '.';
			if (tam == 7)
				campo.value = vr.substr(0, 3) + '.' + vr.substr(3, 6) + '.';
			if (tam == 11)
				campo.value = vr.substr(0, 3) + '.' + vr.substr(3, 3) + '.' + vr.substr(7, 3) + '-' + vr.substr(11, 2);
		}
	}


function mascara(src, mask){
var i = src.value.length;
var saida = mask.substring(0,1);
var texto = mask.substring(i)
if (texto.substring(0,1) != saida)
{
src.value += texto.substring(0,1);
}
}

$(document).ready(function(){
    $(document).ready(function() {
				$("#search","search_cpf").keypress(verificaNumero);
			});

    $('#formulario_rg').keyup(function(){
        mascara(this,"##.###.###-#")
    })
    $('#search_cpf').keyup(function(){
        mascara(this,"###.###.###-##")
    })
    $('#home_cpf').keyup(function(){
        mascara(this,"###.###.###-##")
    })

    $('#formulario_cep').keyup(function(){
        mascara(this,"##.###-###")
    })

    $('#formulario_telefone_numero').keyup(function(){
        mascara(this,"####-####")
    })
    $('#formulario_celular_numero').keyup(function(){
        mascara(this,"####-####")
    })


    $('#formulario_cpf').keyup(function(){
        FormataCpf(this,"keyup")
    })

	$('a.login-window').click(function() {

                //Getting the variable's value from a link
		var loginBox = $(this).attr('href');

		//Fade in the Popup
		$(loginBox).fadeIn(300);

		//Set the center alignment padding + border see css style
		var popMargTop = ($(loginBox).height() + 24) / 2;
		var popMargLeft = ($(loginBox).width() + 24) / 2;

		$(loginBox).css({
			'margin-top' : -popMargTop,
			'margin-left' : -popMargLeft
		});

		// Add the mask to body
		$('body').append('<div id="mask"></div>');
		$('#mask').fadeIn(300);

		return false;
	});

	// When clicking on the button close or the mask layer the popup closed
	$('a.close, #mask').live('click', function() {
	  $('#mask , .login-popup').fadeOut(300 , function() {
		$('#mask').remove();
	});
	return false;
	});
        // Transforma link em botão
        $("#inscreva-se").button();
        $("#login").button();
        $("#contato").button();

});

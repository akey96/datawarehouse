// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Pie Chart Example
var ctx = document.getElementById("pie_pagos");

const url = 'http://localhost:8080/hechos-pagos-estadisticos'
const http = new XMLHttpRequest()




http.open("GET", url)
http.onreadystatechange = function() {

    if (this.readyState == 4 && this.status == 200) {
        var resultado = JSON.parse(this.responseText)
        var labels = []
        var data = []
        var html_conclusion = '';
        let resultadoFinal = []


        var promedio_nacional = 0;
        for (const ciudad in resultado.message) {
            promedio_nacional += resultado.message[ciudad].promedio;
        }
        promedio_nacional = (promedio_nacional / 9);

        for (var i = 0; i < 9; i++) {
            resultadoFinal.push(resultado.message[i])
        }
        for (pago of resultadoFinal) {
            labels.push(pago.lugar_hotel.trim())
            data.push(pago.total)
            console.log(pago)


            document.querySelector('#conclusion').innerHTML = html_conclusion;

            if (parseInt(pago.promedio) < parseInt(promedio_nacional)) {
                html_conclusion += `<button style="text-align: left" disabled class="btn btn-success text-nowrap" type="button">
                                  El total de pago de habitaciones del ${pago.lugar_hotel.trim()} es:  ${pago.total}, <br> y esta por encima del promedio nacional
                                </button>
                                <br><br>`;
            } else {
                html_conclusion += `<button style="text-align: left" disabled class="btn btn-danger text-nowrap" type="button">
                                  El total de pago de habitaciones del ${pago.lugar_hotel.trim()} es:  ${pago.total}, <br> y esta por debajo del promedio nacional
                                </button>
                                <br><br>`;
            }
        }
        var myPieChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745', '#8e44ad', '#3498db', '#839192', '#f1c40f', '#a3e4d7'],
                }],
            },
        });

    }
}
http.send()
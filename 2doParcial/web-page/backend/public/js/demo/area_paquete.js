// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';


const url = 'http://localhost:8080/hechos-demanda-paquetes-turisticos'
const http = new XMLHttpRequest()
var myLineChart = null
var resultado = [];
http.open("GET", url)


function cargarCanvas(e) {
    let paquete = resultado.message.filter(word => word.paquete_turistico.trim() == e.innerHTML)[0]
    console.log(paquete)
    var ctx = document.getElementById("area_paquetes")

    document.querySelector('#crecimiento').innerHTML = `<div class="mr-5">2017-2018  
                                                        ${paquete.porcentaje_crecimiento_2018<0 ? "decremento del "+paquete.porcentaje_crecimiento_2018+" %" : "incremento del "+paquete.porcentaje_crecimiento_2018+" %"} </div>
                                                        <br>
                                                        <div class="mr-5">2018-2019  
                                                        ${paquete.porcentaje_crecimiento_2019<0 ? "decremento del "+paquete.porcentaje_crecimiento_2019+" %" : "incremento del "+paquete.porcentaje_crecimiento_2019+" %"} </div>
                                                        `
    document.querySelector('#seleccionable').innerHTML = paquete.paquete_turistico.trim()
    document.querySelector('#conclusion').innerHTML = `<button disabled class="btn btn-${paquete.porcentaje_crecimiento_2018>0 && paquete.porcentaje_crecimiento_2019>0 ? "success":"danger" } text-nowrap" type="button">
                                                            ${paquete.porcentaje_crecimiento_2018>0 && paquete.porcentaje_crecimiento_2019>0 ? "Se es recomendable invertir en este paquete, ya que exite un incremente en los ultimos años":"No es recomendable invertir en este paquete, ya que exite un decremento en los ultimos años" } 
                                                        </button>`
    if (myLineChart == null) {
        myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["2017", "2018", "2019"],
                datasets: [{
                    label: paquete.paquete_turistico.trim(),
                    lineTension: 0.3,
                    backgroundColor: "rgba(2,117,216,0.2)",
                    borderColor: "rgba(2,117,216,1)",
                    pointRadius: 5,
                    pointBackgroundColor: "rgba(2,117,216,1)",
                    pointBorderColor: "rgba(255,255,255,0.8)",
                    pointHoverRadius: 5,
                    pointHoverBackgroundColor: "rgba(2,117,216,1)",
                    pointHitRadius: 50,
                    pointBorderWidth: 2,
                    data: [paquete.demanda_2017, paquete.demanda_2018, paquete.demanda_2019],
                }],
            },
            options: {
                scales: {
                    xAxes: [{
                        time: {
                            unit: 'date'
                        },
                        gridLines: {
                            display: false
                        },
                        ticks: {
                            maxTicksLimit: 7
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            min: 0,
                            max: Math.max(paquete.demanda_2017, paquete.demanda_2018, paquete.demanda_2019) + 10,
                            maxTicksLimit: 5
                        },
                        gridLines: {
                            color: "rgba(0, 0, 0, .125)",
                        }
                    }],
                },
                legend: {
                    display: false
                }
            }
        });
    } else {
        myLineChart.data.datasets[0].data = [paquete.demanda_2017, paquete.demanda_2018, paquete.demanda_2019];
        myLineChart.options.scales.yAxes[0].ticks.max = Math.max(paquete.demanda_2017, paquete.demanda_2018, paquete.demanda_2019) + 10
        myLineChart.update();
    }


}

http.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        resultado = JSON.parse(this.responseText)

        var html_menu = ''
        for (paquete of resultado.message) {
            html_menu += `<button onclick="cargarCanvas(this)" class="dropdown-item" type="button">${paquete.paquete_turistico.trim()}</button>`
        }
        document.querySelector('#menu_paquetes').innerHTML = html_menu


    }

}
http.send()
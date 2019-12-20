// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';


const url = 'http://localhost:8080/hechos-reserva-habitaciones-ambientes'
const http = new XMLHttpRequest()
var myLineChart = null
var myPieChart = null
var resultado = [];
http.open("GET", url)


function cargarHotel(e) {

    let hotel = resultado.message.filter(word => word.nombre_hotel.trim() == e.id)[0]

    let ctxPie = document.getElementById("myPieChart");
    console.log(hotel)
    if (myPieChart == null) {
        myPieChart = new Chart(ctxPie, {
            type: 'pie',
            data: {
                labels: ["2017", "2018", "2019"],
                datasets: [{
                    data: [parseInt(hotel.reservas2017), parseInt(hotel.reservas2018), parseInt(hotel.reservas2019)],
                    backgroundColor: ['#007bff', '#dc3545', '#ffc107'],
                }],
            },
        });
    } else {
        myPieChart.data.datasets[0].data = [parseInt(hotel.reservas2017), parseInt(hotel.reservas2018), parseInt(hotel.reservas2019)];
        myPieChart.update();
    }
    document.querySelector("#conclusionHotel").innerHTML = `Ingresos del hotel ${hotel.nombre_hotel} por año`


}


function cargarCanvas(e) {

    let hoteles = resultado.message.filter(word => word.lugar_hotel.trim() == e.innerHTML)
    var ctx = document.getElementById("area_hoteles")

    let colores = [
        '99, 57, 116',
        '241, 196, 15',
        '231, 76, 60',
        '41, 128, 185',
        '23, 165, 137',
        '46, 204, 113',
        '241, 196, 15',
    ]
    let datasets = []
    let max = 0
    var html_conclusion = ''
    hoteles.forEach((hotel, index) => {
        let data = []
        max = Math.max(max, hotel.reservas2017, hotel.reservas2018, hotel.reservas2019)
        data.push(hotel.reservas2017)
        data.push(hotel.reservas2018)
        data.push(hotel.reservas2019)
        datasets.push({
            label: hotel.nombre_hotel.trim(),
            lineTension: 0.3,
            backgroundColor: `rgba(${colores[index]},0.2)`,
            borderColor: `rgba(${colores[index]},1)`,
            pointRadius: 5,
            pointBackgroundColor: "rgba(2,117,216,1)",
            pointBorderColor: `rgba(${colores[index]},1)`,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: `rgba(${colores[index]},1)`,
            pointHitRadius: 50,
            pointBorderWidth: 2,
            data: data,
        })

        if (hotel.porcentaje_crecimiento_reserva_2018 > 0 && hotel.porcentaje_crecimiento_reserva_2019 > 0) {
            // caso correcto
            html_conclusion += `<button onclick="cargarHotel(this)" id="${hotel.nombre_hotel.trim()}"  class="btn btn-success text-nowrap" type="button">
                                El hotel ${hotel.nombre_hotel.trim()} tiene un incremento en los años 2018 y 2019, se recomienda invertir 
                                </button>
                                <br><br>`
        } else {
            // caso incorrecto
            html_conclusion += `<button onclick="cargarHotel(this)" id="${hotel.nombre_hotel.trim()}" class="btn btn-danger text-nowrap" type="button">
                                El hotel ${hotel.nombre_hotel.trim()} tiene un decremento en los años 2018 y 2019, se recomienda no invertir 
                                </button>
                                <br><br>`
        }


    });
    document.querySelector('#conclusion').innerHTML = html_conclusion;
    document.querySelector('#contenido_hotel').innerHTML = `Uso de las habitaciones de hoteles de la ciudad de ${hoteles[0].lugar_hotel.trim()}`
    document.querySelector('#seleccionable').innerHTML = hoteles[0].lugar_hotel.trim()
        /*
    
            document.querySelector('#crecimiento').innerHTML = `<div class="mr-5">2017-2018  
                                                                ${paquete.porcentaje_crecimiento_2018<0 ? "decremento del "+paquete.porcentaje_crecimiento_2018+" %" : "incremento del "+paquete.porcentaje_crecimiento_2018+" %"} </div>
                                                                <br>
                                                                <div class="mr-5">2018-2019  
                                                                ${paquete.porcentaje_crecimiento_2019<0 ? "decremento del "+paquete.porcentaje_crecimiento_2019+" %" : "incremento del "+paquete.porcentaje_crecimiento_2019+" %"} </div>
                                                                `
    
            document.querySelector('#conclusion').innerHTML = `<button disabled class="btn btn-${paquete.porcentaje_crecimiento_2018>0 && paquete.porcentaje_crecimiento_2019>0 ? "success":"danger" } text-nowrap" type="button">
                                                                    ${paquete.porcentaje_crecimiento_2018>0 && paquete.porcentaje_crecimiento_2019>0 ? "Se es recomendable invertir en este paquete, ya que exite un incremente en los ultimos años":"No es recomendable invertir en este paquete, ya que exite un decremento en los ultimos años" } 
                                                                </button>`
            */
    if (myLineChart == null) {
        myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["2017", "2018", "2019"],
                datasets: datasets,
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
                            max: max + 10,
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
        myLineChart.data.datasets = datasets;
        myLineChart.options.scales.yAxes[0].ticks.max = max + 10
        myLineChart.update();
    }


}

http.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        resultado = JSON.parse(this.responseText)
        var departamentos = ["oruro", "potosi", "la paz", "cochabamba", "chuquisaca", "tarija", "santa cruz", "beni", "pando"]
        var html_menu = ''
        for (departamento of departamentos) {
            html_menu += `<button onclick="cargarCanvas(this)" class="dropdown-item" type="button">${departamento}</button>`
        }
        document.querySelector('#menu_paquetes').innerHTML = html_menu


    }

}
http.send()
<?php 

include('Consumir.php');

error_reporting(0);

$consumirApi = new ConsumirApi();

$data_array = "";
$data_json = "";
if (isset($_GET['consumir'])) {

	// Obtenemos URL
	$consumirApi->asignarURL($_GET['url']);

	// Obtenemos el objeto convertido a Array
    $data_array = $consumirApi->jsonDecodeApi();

    // Obtenemos el objeto convertido en Json
    $data_json = $consumirApi->jsonApi();

	// Extraemos solo color rojo
    $data_filter = $consumirApi->extraerColor($data_array,'red');

}

if (isset($_GET['limpiar'])) {
	header("Location: consumir2.php");
	die();
}

?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>DP Ejercicio 1 | 1</title>
</head>
<style>
	table, th, td {
	  border:1px solid black;
	}
</style>
<body>

	<form action="" method="get">
		<input type="text" name="url" value="https://my-json-server.typicode.com/dp-danielortiz/dptest_jsonplaceholder/items">
		<button type="submit" name="consumir">Consumir</button>
		<button type="submit" name="limpiar">Limpiar</button>
	</form>

	<br>

	<div id="resultado">
	</div>

</body>
<script type="text/javascript">

	let dataJson = [];
	try {
	    dataJson = JSON.parse('<?php echo json_encode(array_values($data_filter)); ?>');
	} catch (d) {}

	if (dataJson.length > 0 ) {
		mostrarDatos(dataJson);
	}

	function mostrarDatos(dataJson) {
		let resultado = document.getElementById('resultado');

		let tabla = "<table>";
    				  tabla += "<tr>";
    				  tabla += "<th>Id</th><th>Type</th><th>Color</th>";
    				  tabla += "</tr>";
		dataJson.forEach( function(valor, indice, array) {

			tabla += "<tr>";
			tabla += "<td>"+valor.id+"</td><td>"+valor.type+"</td><td>"+valor.color+"</td>";
			tabla += "</tr>";
	  
		});
		tabla += "</table>";

		resultado.innerHTML = tabla;
	}

</script>
</html>
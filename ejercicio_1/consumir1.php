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

	// Exportamos a archivo JSON
    $consumirApi->crearArchivoJson($data_json);

}

if (isset($_GET['limpiar'])) {
	header("Location: consumir1.php");
	die();
}

?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>DP Ejercicio 1 | 1</title>
</head>
<body>

	<form action="" method="get">
		<input type="text" name="url" value="https://my-json-server.typicode.com/dp-danielortiz/dptest_jsonplaceholder/items">
		<button type="submit" name="consumir">Consumir</button>
		<button type="submit" name="limpiar">Limpiar</button>
	</form>

	<br>

	<?php 

	$data_array = $consumirApi->extraerColor($data_array, 'green');

	// Imprimimos en pantalla solo los green
	echo('<pre>');
	print_r($data_array);
	echo('</pre>');

	?>

</body>
</html>
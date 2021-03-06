<?php 

class ConsumirApi {

	protected $url;


	public function obtenerURL() {
		return $this->url;
	}

	public function asignarURL($val) {
		$this->url = $val;
		return $this;
	}

	public function jsonApi() {
		$json = file_get_contents($this->obtenerURL());
		return $json;
	}

	public function jsonDecodeApi() {
		$json = json_decode( file_get_contents($this->obtenerURL()), true);
		return $json;
	}

	public function extraerColor($data_array, $color) {
		foreach ($data_array as $key => $value) {
			if ( $value['color'] != $color) {
				unset($data_array[$key]);
			}
		}
		return $data_array;
	}

	public function crearArchivoJson($json) {
		$archivo = fopen("Respuesta1.json", "w+");
		fwrite($archivo, $json);
		fclose($archivo);
	}

}

?>
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

}

?>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace formulario_dp
{
    internal class Conexion
    {

        public static MySqlConnection conexion()
        {
            string servidor = "localhost";
            string bd = "practica_dp";
            string usuario = "root";
            string password = "";

            string cadenaConexion = "Database="+bd+"; Data Source="+servidor+"; User Id="+usuario+"; Password="+password+"";

            try {
                MySqlConnection conexionBD = new MySqlConnection(cadenaConexion);

                return conexionBD;
            }
            catch(MySqlException ex) {
                Console.WriteLine("Error: " + ex.Message);

                return null;
            }
        }

    }
}
